let pendingBicycles = [];

var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var path = require('path');
var app = express();

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
    req.session.destroy(function(err) {
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

    console.log(typeof(timestamp));

    if (bicycle_id && gateway_id && longitude && latitude && timestamp) {
        connection.query('INSERT INTO locations (bicycle_id, gateway_id, longitude, latitude, timestamp) VALUES(?, ?, ?, ?, ?)', [bicycle_id, gateway_id, longitude, latitude, timestamp], (error, results) => {
            if (error) throw error;
            console.log(`Inserted into locations - Bicycle ID: ${bicycle_id}, Gateway ID: ${gateway_id}, Longitude: ${longitude}, Latitude: ${latitude}, Timestamp: ${timestamp}`);
            res.end();
        });
    }
});

app.get('/locations/get/all', (req, res) => {
    let response = {};

    connection.query('SELECT * FROM locations', (error, results, fields) => {
        if (error) throw error;

        if (results.length > 0) {
            response = results;
        
            res.send(response);
        }
    });
});

app.post('/bicycles/update', (req, res) => {
    let pending = {};
    pending.bicycle_id = parseInt(req.body.bicycle_id);
    pending.gateway_id = parseInt(req.body.gateway_id);
    pendingBicycles.push(pending);

    const timeoutObj = setTimeout(() => {
        console.log("Started Timeout!");
    }, 5000);

    res.end();
});

app.post('/bicycles/rent', (req, res) => {
    if (session.loggedin) {
        let bicycle_id = req.body.bicycle_id;

        for (let i = 0; i < pendingBicycles.length; i++) {
            if (pendingBicycles[i].bicycle_id == bicycle_id) {

            }
        }
    } else {
        res.redirect('/login');
    }
});

app.listen(9000);