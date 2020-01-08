let pendingBicycles = [];
let timeouts = [];

const mysql = require('mysql');
const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
const app = express();

var connection = mysql.createConnection({
	host     : 'localhost',
	user     : 'debian-sys-maint',
	password : 'KXKwHm2d84fVuc43',
	database : 'FreePublicBicycles'
});

connection.connect((err) => {
    if (err) throw err;
    console.log('Connected!');
});

app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true
}));

app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());
app.use(express.static('public'));

app.get('/home', (req, res) => {
    if (req.session.loggedin) {
        res.sendFile(path.join(__dirname + '/public/home.html'));
    } else {
        res.redirect('/login');
    }
});

app.get('/map', (req, res) => {
    if (req.session.loggedin) {
        res.sendFile(path.join(__dirname + '/public/map.html'));
    } else {
        res.redirect('/login');
    }
});

app.get('/profile', (req, res) => {
    if (req.session.loggedin) {
        res.sendFile(path.join(__dirname + '/public/profile.html'));
    } else {
        res.redirect('/login');
    }
});

app.get('/login', (req, res) => {
    if (req.session.loggedin) {
        res.redirect('/home');
    } else {
        res.sendFile(path.join(__dirname + '/public/login.html'));
    }  
});

app.post('/auth', (req, res) => {
    let username = req.body.username;
    let password = req.body.password;

    if (username && password) {
        connection.query('SELECT * FROM accounts WHERE username = ? AND password = ?', [username, password], (error, results, fields) => {
            if (results.length > 0) {
                req.session.loggedin = true;
                req.session.username = username;
                res.redirect('/home');
            } else {
                res.send('Incorrect Username and/or Password!');
            }

            res.end();
        });
    } else {
        res.send('Please enter Username and Password!');
        res.end();
    }
});

app.get('/register', (req, res) => {
    if (req.session.loggedin) {
        res.redirect('/home');
    } else {
        res.sendFile(path.join(__dirname + "/public/register.html"));
    }
});

app.post('/register', (req, res) => {
    let username = req.body.username;
    let email = req.body.email;
    let password = req.body.password;

    if (username && email && password) {
        connection.query('INSERT INTO accounts (username, password, email) VALUES(?, ?, ?)', [username, password, email], (error, results) => {
            if (error) throw error;
            console.log(`Client Registered: Username: ${username}, Password: ${password}, Email: ${email}`);
            req.session.loggedin = true;
            req.session.username = username;
            res.redirect('/home');
            res.end();
        });
    }
});

app.get('/logout', (req, res) => {
    req.session.destroy((err) => {
        if (err) {
            console.log(err);
        } else {
            res.redirect('/login');
        }
    });
});

app.put('/locations/add', (req, res) => {
    let bicycle_id = parseInt(req.body.bicycle_id);
    let gateway_id = parseInt(req.body.gateway_id);
    let longitude = parseFloat(req.body.longitude);
    let latitude = parseFloat(req.body.latitude);
    let timestamp = req.body.timestamp;

    if (bicycle_id && gateway_id && longitude && latitude && timestamp) {
        connection.query('INSERT INTO locations (bicycle_id, gateway_id, longitude, latitude, timestamp) VALUES(?, ?, ?, ?, ?)', [bicycle_id, gateway_id, longitude, latitude, timestamp], (error, results) => {
            if (error) throw error;
            res.end();
        });
    }
});

app.get('/bicycles/get/all', (req, res) => {
    let response = {};

    connection.query('SELECT * FROM locations', (error, results, fields) => {
        if (error) throw error;

        if (results.length > 0) {
            response = results;
        
            res.send(response);
        }
    });
});

app.get('/bicycles/get/free', (req, res) => {
    connection.query('SELECT * FROM bicycles as b INNER JOIN (SELECT * FROM (SELECT DISTINCT * FROM locations as e order by timestamp desc) as l group by bicycle_id) as y ON b.bicycle_id = y.bicycle_id AND b.status = 0', (error, results, fields) => {        
        if (error) throw error;

        if (results.length > 0) {
            res.send(results);
        }
    });
});

app.post('/bicycles/update', (req, res) => {
    let bicycle_id = parseInt(req.body.bicycle_id);
    let gateway_id = parseInt(req.body.gateway_id);
    let found = false;

    for (let i = 0; i < pendingBicycles.length; i++) {
        if (pendingBicycles[i].bicycle_id == bicycle_id && !pendingBicycles[i].click) {
            let bicycle = pendingBicycles[i];
            pendingBicycles.splice(i, 1);
            timeouts.splice(i, 1);

            connection.query('UPDATE bicycles SET status = 1 WHERE bicycle_id = ?', bicycle.bicycle_id, (error, results) => {
                if (error) throw eror;
                console.log(`Changed status of biycle: ${bicycle.bicycle_id} to occupied (1)`);
            });
            
            found = true;
            break;
        }
    }

    if (found) {
        let response = {
            bicycle_id: bicycle_id,
            gateway_id: gateway_id,
            status: true
        };

        res.send(response);
    } else {
        res.send("Invalid request");
    }
});

app.post('/bicycles/rent', (req, res) => {
    let bicycle_id = parseInt(req.body.bicycle_id); 
    let gateway_id = parseInt(req.body.gateway_id); 

    let pending = {
        bicycle_id: bicycle_id,
        gateway_id: gateway_id,
        click: false
    };

    pendingBicycles.push(pending);

    let timeout = setTimeout(() => {        
        let index;

        for (let i = 0; i < pendingBicycles.length; i++) {
            if (pendingBicycles[i].bicycle_id == bicycle_id) {
                index = i;
            }
        }

        try {    
            if (!pendingBicycles[index].click) {
                pendingBicycles.splice(index, 1);
                timeouts.splice(index, 1);
            }            
        } catch (error) {
            console.log("Pending bicycle expired or rented.");
        }
    }, 10000);

    timeouts.push(timeout);
    res.end();
});

app.listen(9000);
