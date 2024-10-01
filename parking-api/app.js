const express = require('express');
const userRoutes = require('./routes/userRoutes');
const bodyParser = require('body-parser');
const app = express();

var cors = require('cors');
app.use(cors());
app.use(function(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  res.setHeader('Access-Control-Allow-Credentials', true);
  next();
});

// Middleware
app.use(bodyParser.json());

// Routes
app.use('/api', userRoutes);

const PORT  = 7000;
app.listen(PORT,()=>{
    console.log(`App connected to port ${PORT}`);
})