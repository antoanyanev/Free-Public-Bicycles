const mysql = require('mysql'); // Require mysql client
const express = require('express'); // Require express to manage HTTP requests
const session = require('express-session'); // Require express session to manage user sessions
const bodyParser = require('body-parser'); // Require body parser to parse request data
const path = require('path'); // Require path to mange directories
const app = express(); // Create express app
const https = require('https'); // Require https to create a secureconnection
const fs = require('fs'); // Require filestream to read 
const passwordHash = require('password-hash');

let pendingBicycles = []; // List of pending rents
let timeouts = []; // List of timeout objects for renting

var connection = mysql.createConnection({ // Create a connection to SQL database
	host     : 'localhost',
	user     : 'debian-sys-maint',
	password : 'KXKwHm2d84fVuc43',
	database : 'FreePublicBicycles'
});

connection.connect((err) => { // Check for DB connection errors
    if (err) throw err;
    console.log('Connected!');
});

app.use(session({ // Set session parameters
	secret: 'bicycle',
	resave: true,
	saveUninitialized: true
}));

app.use(bodyParser.urlencoded({extended : true})); // Enable parser to work with URL encoded bodies
app.use(bodyParser.json()); // Enable body parser to work with JSON format
app.use(express.static('public')); // Set a folder with static files for routing

app.get('/', (req, res) => {
    res.redirect('/home');
})

app.get('/home', (req, res) => { // Redirect user to home page
    if (req.session.loggedin) { // Check for existing connection
        res.sendFile(path.join(__dirname + '/public/home.html')); // Redirect to home page
    } else {
        res.redirect('/login'); // Redirect to login page
    }
});

app.get('/map', (req, res) => { // Redirects user to map page
    if (req.session.loggedin) { // Check for existing session
        res.sendFile(path.join(__dirname + '/public/map.html')); // Redirect to map page
    } else {
        res.redirect('/login'); // Redirect to login page
    }
});

app.get('/profile', (req, res) => { // Redirect user to profile page
    if (req.session.loggedin) { // Check for existing session
        res.sendFile(path.join(__dirname + '/public/profile.html')); // Redirect to profile page
    } else {
        res.redirect('/login'); // Redurect to login page
    }
});

app.get('/login', (req, res) => { // Redirect user to login page
    if (req.session.loggedin) { // Check for existing session
        res.redirect('/home'); // Redirect to home page
    } else {
        res.sendFile(path.join(__dirname + '/public/login.html')); // Redirect to login page
    }  
});

app.post('/auth', (req, res) => { // Check users log in credentials
    // Acquire request parameters
    let username = req.body.username;
    let password = req.body.password;
    let hashedPassword;
    let sql;

    // Check if all parameters have been sent
    if (checkUsername(username) && password) {
        sql = 'SELECT * FROM accounts WHERE username = ?';
        query(sql, [username]).then((results) => {
            hashedPassword = results[0].password;

            if (passwordHash.verify(password, hashedPassword)) {
                // Look up user in DB
                sql = 'SELECT * FROM accounts WHERE username = ? AND password = ?';
                query(sql, [username, hashedPassword]).then((results) => {
                if (results.length > 0) {
                    req.session.loggedin = true; // Begin new session
                    req.session.username = username;
                    req.session.userID = parseInt(results[0].id);
                    req.session.bicycle_id = null;
                    req.session.gateway_id = null;
                    req.session.status = 0;
                    res.redirect('/home'); // redirect user to home page
                } else {
                    res.send('Incorrect Username and/or Password!'); // Send acknowledgement for incorrent log in credentials
                }
    
                res.end();
            });   
            } else {
                res.send('Incorrect Username and/or Password!');
            }
        });
    } else {
        res.send('Please enter Username and Password!');
        res.end();
    }
});

app.get('/register', (req, res) => { // Redirects user to the register page
    if (req.session.loggedin) { // Checks if the user has an active session
        res.redirect('/home'); // redirect to home page if user is already loged in
    } else {
        res.sendFile(path.join(__dirname + "/public/register.html")); // Redirect to registerpage
    }
});

app.post('/register', (req, res) => { // Register new user
    // Acquire user parameters from request
    let username = req.body.username;
    let email = req.body.email;
    let password = req.body.password;
    let sql;

    // Check if all parameters have been sent
    if (checkUsername(username) && checkEmail(email) && checkPassword(password)) {
        // Insert new user into DB
        let hashedPassword = passwordHash.generate(password);
        sql = 'INSERT INTO accounts (username, password, email) VALUES(?, ?, ?)';
        query(sql, [username, hashedPassword, email]).then((results) => {
            req.session.loggedin = true; // Begin a session for the new user
            req.session.username = username;
            req.session.email = email;
            req.session.bicycle_id = null;
            req.session.gateway_id = null;
            req.session.status = 0;
            res.redirect('/home'); // Redirect user to the homepage
            res.end(); // Send response
        });

        sql = 'SELECT * FROM accounts WHERE username = ?';
        query(sql, [username]).then((results) => {
            req.session.userID = parseInt(results[0].id);
        });
    }
});

app.get('/logout', (req, res) => { // Ends user session
    req.session.destroy((err) => { // Destroy session
        if (err) {
            console.log(err);
        } else {
            res.redirect('/login'); // Redirect user to login page
        }
    });
});

app.put('/locations/add', (req, res) => { // Register a bicycle location in DB
    // Parse parameters from PUT request
    let bicycle_id = parseInt(req.body.bicycle_id);
    let gateway_id = parseInt(req.body.gateway_id);
    let longitude = parseFloat(req.body.longitude);
    let latitude = parseFloat(req.body.latitude);
    let timestamp = req.body.timestamp;
    let battery = parseInt(req.body.battery);
    let sql;

    // Check if all parameters have been sent
    if (bicycle_id && gateway_id && longitude && latitude && timestamp) {
        // Insert paramters into DB

        sql = 'SELECT bicycles.bicycle_id FROM bicycles WHERE bicycles.bicycle_id = ?';
        query(sql, [bicycle_id]).then((results) => {
            if (results.length <= 0) {
                sql = 'INSERT INTO bicycles (status, bicycle_id) VALUES (0, ?)';
                query(sql, [bicycle_id]).then((results) => {});
            }
            
            sql = 'INSERT INTO locations (bicycle_id, gateway_id, longitude, latitude, timestamp, battery) VALUES(?, ?, ?, ?, ?, ?)';
            query(sql, [bicycle_id, gateway_id, longitude, latitude, timestamp, battery]).then((results) => {
                res.end();
            });
        });
    }
});

app.get('/bicycles/get/all', (req, res) => { // Return a list of all bicycles
    // Get all bicycles from DB
    let sql = 'SELECT * FROM locations';
    query(sql, []).then((results) => {
        if (results.length > 0)
            res.send(results);
    });
});

app.get('/bicycles/get/free', (req, res) => { // Return list of available free bicycles
    // Get all free bicycles from DB
    let sql = 'SELECT * FROM bicycles as b INNER JOIN (SELECT * FROM (SELECT DISTINCT * FROM locations as e order by timestamp desc) as l group by bicycle_id) as y ON b.bicycle_id = y.bicycle_id AND b.status = 0 AND y.battery > 30';
    query(sql, []).then((results) => {
        if (results.length > 0) 
            res.send(results);
    });
});

app.post('/bicycles/update', (req, res) => { // Bicycle button press; second
    // Parse parameters from request
    let bicycle_id = parseInt(req.body.bicycle_id);
    let gateway_id = parseInt(req.body.gateway_id);
    let found = false;
    let sql;

    // Check all bicycles with pending status
    for (let i = 0; i < pendingBicycles.length; i++) {
        if (pendingBicycles[i].bicycle_id == bicycle_id && !pendingBicycles[i].click) { // Search for request bike 
            let bicycle = pendingBicycles[i];
            pendingBicycles.splice(i, 1); // Remove bicycle from pending list
            timeouts.splice(i, 1); // Remove bicycle from timeouts list

            // Change status of bicycle to occupied
            sql = 'UPDATE bicycles SET status = 1 WHERE bicycle_id = ?';
            query(sql, bicycle.bicycle_id).then((results) => { });

            found = true;
            break;
        }
    }

    if (found) { // Check if the requested bicycle's status has been updated
        let response = {  // Create response
            bicycle_id: bicycle_id,
            gateway_id: gateway_id,
            status: true
        };

        req.session.bicycle_id = bicycle_id;
        req.session.gateway_id = gateway_id;
        req.session.status = true;
        req.session.timestamp = (new Date()).toISOString().slice(0, 19).replace(/-/g, "/").replace("T", " ");
        res.send(response); // Send JSON response
    } else {
        res.send("Invalid request"); // Send invalid request aknowledgement
    }
});

app.post('/bicycles/rent', (req, res) => { // Website button; first
    // Parse request parameters
    let bicycle_id = parseInt(req.body.bicycle_id); 
    let gateway_id = parseInt(req.body.gateway_id); 

    // Create bicycle object
    let pending = {
        bicycle_id: bicycle_id,
        gateway_id: gateway_id,
        click: false
    };

    pendingBicycles.push(pending); // Push bicycle object into pending list

    let timeout = setTimeout(() => { // Checks if a request to /bicycles/rent has been made in the specified interval of time        
        let index;

        for (let i = 0; i < pendingBicycles.length; i++) { // Find the index of the requested bicycle
            if (pendingBicycles[i].bicycle_id == bicycle_id) {
                index = i;
            }
        }

        try { 
            if (!pendingBicycles[index].click) { // Check if requested bicycles has been rented
                pendingBicycles.splice(index, 1); // Remove bicycle from pending list
                timeouts.splice(index, 1); // Remove bicycle from timeouts
            }            
        } catch (error) {
            console.log("Pending bicycle expired or rented."); // Send error acknowledgement
        }
    }, 10000);

    timeouts.push(timeout); // Add timeout to timeouts list
    res.end();
});

app.get('/user/status', (req, res) => { // Get user's status
    let response = { // Create response JSON object
        bicycle_id: req.session.bicycle_id, // Bicycle_id
        gateway_id: req.session.gateway_id, // Gateway_id
        status: req.session.status // Status of user
    };

    res.send(response); // Send JSON response
});

app.post('/bicycles/letgo', (req, res) => { // Let go of rented bicycle
    let sql; // Create sql query string
    let username = req.session.username; // Extract username 
    let email = req.session.email; // Extract email
    let id = req.session.userID; // Extract user id
    let timestamp = req.session.timestamp; // Extrat time of renting
    let biggestTripId = 0; // Initialize bigest trip number id
    let bicycle_id = req.session.bicycle_id; // Extract rented bicycle id
    let values = []; // All location from new trip

    // Set rented bicycle's status to vacant
    sql = 'UPDATE bicycles SET status = 0 WHERE bicycle_id = ?';
    query(sql, [req.body.bicycle_id]).then((results) => {

    });

    // Extract biggest trip ID
    sql = 'SELECT a.id, t.tripID FROM accounts as a INNER JOIN accountToTrip as t ON a.id = t.accountID WHERE a.username = ?'
    query(sql, [username]).then((results) => {
        for (let i = 0; i < results.length; i++) {
            if (results[i].tripID > biggestTripId) {
                biggestTripId = results[i].tripID;
            }
        }

        // Insert locations into new trip
        biggestTripId++;
        sql = `INSERT INTO accountToTrip (accountID, tripID) VALUES (?, ?)`;
        query(sql, [id, biggestTripId]).then((results) => {
            // Select all location of rented bike after renting timestamp
            sql = 'SELECT locations.id, locations.bicycle_id FROM locations WHERE timestamp > ? ORDER BY bicycle_id, timestamp';
            query(sql, [req.session.timestamp]).then((results) => {
                for (let i = 0; i < results.length; i++) {
                    if (bicycle_id == results[i].bicycle_id) {
                        values.push([biggestTripId, results[i].id, id, bicycle_id]);
                    }
                }

                // Insert values into trip
                sql = 'INSERT INTO trips (id, locationID, userID, bicycle_id) VALUES ?';
                query(sql, [values]).then((results) => {

                });
            });
        });
    });

    req.session.bicycle_id = null; // Reset user's current bicycle id
    req.session.gateway_id = null; // Reset user's current gateway_id
    req.session.status = 0; // Set user's status to free

    res.end(); // End HTTPS response
});

app.get('/user/trips/all', (req, res) => { // Get all trips for user
    let sql = 'SELECT * FROM trips WHERE userID = ?';
    query(sql, [req.session.userID]).then((results) => {
        res.send(results);
    });
});

https.createServer({ // Create HTTPS server 
    key: fs.readFileSync('server.key'), // Read SSL key
    cert: fs.readFileSync('server.cert') // READ SSL certificate
}, app).listen(443, () => { // Set app to listen ot port 443 for HTTPS
    console.log('Listening...');
});

function query(sql, args) { // MySQL DB query Promise
    return new Promise((resolve, reject) => { // Create new promise
        connection.query(sql, args, (error, results) => { // Execute query
            if (error) {
                return reject(error);
            }
            resolve(results);
        });
    });
}

function checkUsername(username) {
    let re = /^(?=.{4,20}$)[a-zA-Z0-9]/;

    return re.test(username);     
}

function checkPassword(password) {
    let re = /^(?=.*[a-z])(?=.{8,})/

    return re.test(password);
}

function checkEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    
    return re.test(String(email).toLowerCase());
}