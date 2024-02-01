const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const path = require("path");
const coursesRoutes = require('./coursesController');
const CancellationRoutes = require('./CancellationController');

const app = express();
const port = 3030;

// Set Pug as the view engine
app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));

// Set static folder for CSS and other public assets
app.use(express.static(path.join(__dirname, 'public')));

// Use body-parser middleware to parse POST requests
app.use(bodyParser.urlencoded({ extended: true }));

// MySQL Connection
const database = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', 
    database: 'LAB SCHEDULING',
    database: '',
});

database.connect();

// Middleware for session management
app.use(session({
  secret: 'LAB SCHEDULING',
  resave: true,
  saveUninitialized: true,
}));

// Define routes
app.use('/api', coursesRoutes);
app.use('/api', modullesRoutes);

// Routes
app.get("/", (req, res) => {
  res.render("login", { title: "Login Now PRMS" });
});

app.get('/dashboard', (req, res) => {
  if (req.session.user) {
    res.render('dashboard');
  } else {
    res.redirect('/login');
  }
});

app.get("/reg", (req, res) => {
  res.render("register", { title: "Register" });
});

app.get('/login', (req, res) => {
  res.render('login');
});

// Route to handle user login
app.post('/login', (req, res) => {
  const { email, password } = req.body;

  // Check if the user exists in the database
  const selectUserQuery = 'SELECT * FROM students WHERE email = ?';
  db.query(selectUserQuery, [email], (err, users) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).send('Internal Server Error');
      return;
    }

    if (users.length === 0) {
      // User not found, handle accordingly (e.g., show an error message)
      res.status(401).send('Invalid email or password.');
    } else {
      const user = users[0];

      // Compare hashed password using bcrypt
      bcrypt.compare(password, user.password, (err, result) => {
        if (err) {
          console.error('Error comparing passwords:', err);
          res.status(500).send('Internal Server Error');
          return;
        }

        if (result) {
            
          req.session.user = user; 
          res.redirect('/dashboard'); 
        } else {
          // Passwords do not match, handle accordingly (e.g., show an error message)
          res.status(401).send('Invalid email or password.');
        }
      });
    }
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
