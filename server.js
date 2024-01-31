var express = require('express');
var bodyParser = require('body-parser');
var app = express();
var urlencodedParser = bodyParser.urlencoded({ extended: true }); // Fix typo here

var mysql = require('mysql');

var server = app.listen(8080, function () {
    console.log('Server is listening on port 8080');
});

app.use(bodyParser.json());
app.use(express.static('public'));
app.set("view engine", "pug");

app.get('/', function (req, res) { // Fix parentheses to curly braces
    res.render('index');
});

app.get('/contact', function (req, res) { // Fix parentheses to curly braces
    res.render('contact');
});
