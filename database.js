const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'LAB SCHEDULING',
  });
  
  connection.connect();
  module.exports = connection;