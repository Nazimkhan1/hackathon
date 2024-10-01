const express = require('express');
const userRoutes = require('./routes/userRoutes');
const bodyParser = require('body-parser');
const app = express();

// Middleware
app.use(bodyParser.json());

// Routes
app.use('/api', userRoutes);

const PORT  = 7000;
app.listen(PORT,()=>{
    console.log(`App connected to port ${PORT}`);
})