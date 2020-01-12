const mysql = require('mysql'); // Require mysql client
const express = require('express'); // Require express to manage HTTP requests
const session = require('express-session'); // Require express session to manage user sessions
const bodyParser = require('body-parser'); // Require body parser to parse request data
const path = require('path'); // Require path to mange directories
const app = express(); // Create express app
const https = require('https'); // Require https to create a secureconnection
const fs = require('fs'); // Require filestream to read files

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

app.post('/auth', (req, res) => { // Check users loin credentials
    // Acquire request parameters
    let username = req.body.username;
    let password = req.body.password;

    // Check if all parameters have been sent
    if (username && password) {
        // Look up user in DB
        connection.query('SELECT * FROM accounts WHERE username = ? AND password = ?', [username, password], (error, results, fields) => {
            if (results.length > 0) { //
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

    // Check if all parameters have been sent
    if (username && email && password) {
        // Insert new user into DB
        connection.query('INSERT INTO accounts (username, password, email) VALUES(?, ?, ?)', [username, password, email], (error, results) => {
            if (error) throw error;
            req.session.loggedin = true; // Begin a session for the new user
            req.session.username = username;
            req.session.email = email;
            req.session.bicycle_id = null;
            req.session.gateway_id = null;
            req.session.status = 0;
            res.redirect('/home'); // Redirect user to the homepage
            res.end(); // Send response
        });

        connection.query('SELECT * FROM accounts WHERE username = ?', username, (error, results, fields) => {
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

    // Check if all parameters have been sent
    if (bicycle_id && gateway_id && longitude && latitude && timestamp) {
        // Insert paramters into DB
        connection.query('INSERT INTO locations (bicycle_id, gateway_id, longitude, latitude, timestamp) VALUES(?, ?, ?, ?, ?)', [bicycle_id, gateway_id, longitude, latitude, timestamp], (error, results) => {
            if (error) throw error;
            res.end(); // Send response
        });
    }
});

app.get('/bicycles/get/all', (req, res) => { // Return a list of all bicycles
    // Get all bicycles from DB
    connection.query('SELECT * FROM locations', (error, results, fields) => {
        if (error) throw error;

        if (results.length > 0) {        
            res.send(results); // Send JSON response
        }
    });
});

app.get('/bicycles/get/free', (req, res) => { // Return list of available free bicycles
    // Get all free bicycles from DB
    connection.query('SELECT * FROM bicycles as b INNER JOIN (SELECT * FROM (SELECT DISTINCT * FROM locations as e order by timestamp desc) as l group by bicycle_id) as y ON b.bicycle_id = y.bicycle_id AND b.status = 0 AND y.battery > 30', (error, results, fields) => {        
        if (error) throw error;

        if (results.length > 0) {
            res.send(results); // Send JSON as response
        }
    });
});

app.post('/bicycles/update', (req, res) => { // Bicycle button press; second
    // Parse parameters from request
    let bicycle_id = parseInt(req.body.bicycle_id);
    let gateway_id = parseInt(req.body.gateway_id);
    let found = false;

    // Check all bicycles with pending status
    for (let i = 0; i < pendingBicycles.length; i++) {
        if (pendingBicycles[i].bicycle_id == bicycle_id && !pendingBicycles[i].click) { // Search for request bike 
            let bicycle = pendingBicycles[i];
            pendingBicycles.splice(i, 1); // Remove bicycle from pending list
            timeouts.splice(i, 1); // Remove bicycle from timeouts list

            // Change status of bicycle to occupied
            connection.query('UPDATE bicycles SET status = 1 WHERE bicycle_id = ?', bicycle.bicycle_id, (error, results) => {
                if (error) throw eror;
            });

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

app.get('/user/status', (req, res) => {
    let response = {
        bicycle_id: req.session.bicycle_id,
        gateway_id: req.session.gateway_id,
        status: req.session.status
    };

    res.send(response);
});

app.post('/bicycles/letgo', (req, res) => {
    let username = req.session.username;
    let email = req.session.email;
    let password = req.session.password;
    let id = req.session.userID;
    let biggestTripId = 1;

    req.session.bicycle_id = null;
    req.session.gateway_id = null;
    req.session.status = 0;

    connection.query('UPDATE bicycles SET status = 0 WHERE bicycle_id = ?', req.body.bicycle_id, (error, results) => {
        if (error) throw error;
    });

    connection.query('SELECT a.id, t.tripID FROM accounts as a INNER JOIN accountToTrip as t ON a.id = t.accountID WHERE a.username = ?', username, (error, results, fields) => {
        if (error) throw error;
        if (results.length > 0) {
            biggestTripId = parseInt(results[0].tripID);

            results.forEach(r => {
                if (parseInt(r.tripID) > biggestTripId) {
                    biggestTripId = parseInt(r.tripID);
                }
            });

            biggestTripId++;
        }
    });

    connection.query(`INSERT INTO accountToTrip (accountID, tripID) VALUES(?, ?)`, [id, biggestTripId], (error, results) => {
        if (error) throw error;
    });

    res.end();
});

https.createServer({ // Create HTTPS server 
    key: fs.readFileSync('server.key'), // Read SSL key
    cert: fs.readFileSync('server.cert') // READ SSL certificate
}, app).listen(443, () => { // Set app to listen ot port 443 for HTTPS
    console.log('Listening...');
});