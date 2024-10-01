// controllers/userController.js
const User = require('../models/userModel');
const jwt = require('jsonwebtoken');
const redisClient = require('../config/redis');
const secretKey = 'secretKey';

// Get all users

exports.loginPost = (req, res) => {
    const loginData = req.body;
   // console.log(loginData); return false;
    User.getUser(loginData, (err, users) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
          const response = {
                status_code: 1,
                message: 'Your login informations',
                data: users
            };
        
            res.status(202).json(response);
        
        }
    });
};

exports.getAllUsers = (req, res) => {
    User.getAllUsers((err, users) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.json(users);
        }
    });
};

// Get user by ID
exports.getUserById = (req, res) => {
    const userId = req.params.id;
    User.getUserById(userId, (err, user) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else if (!user) {
            res.status(404).json({ message: 'User not found' });
        } else {
            res.json(user);
        }
    });
};

// Create a new user
exports.createUser = (req, res) => {
    const newUser = req.body;
    User.createUser(newUser, (err, userId) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            res.status(201).json({ message: 'User created', userId });
        }
    });
};

// Update a user
exports.updateUser = (req, res) => {
    const userId = req.params.id;
    const updatedUser = req.body;
    User.updateUser(userId, updatedUser, (err, affectedRows) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else if (affectedRows === 0) {
            res.status(404).json({ message: 'User not found' });
        } else {
            res.json({ message: 'User updated' });
        }
    });
};

// Delete a user
exports.deleteUser = (req, res) => {
    const userId = req.params.id;
    User.deleteUser(userId, (err, affectedRows) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else if (affectedRows === 0) {
            res.status(404).json({ message: 'User not found' });
        } else {
            res.json({ message: 'User deleted' });
        }
    });
};

//Login a user

exports.loginUser = async (req, res) => {
    try {
        const { email, password } = req.body;
        const user = await User.getUserByEmail(email, (err, result) => {
            if (err) res.status(401).json({ message: "Invalid Credential" });
            if (result && result.password === password) {
                jwt.sign({ user }, secretKey, { expiresIn: '1h' }, (err, token) => {
                    if (err) throw err;
                    res.json({ Message: "Login Successfull", token });
                });
            } else {
                res.status(401).json({ message: "Invalid Credential" });
            }
        });
    }
    catch (err) {
        res.status(500).json({ error: err.message });
    }
}

// Logout user and blacklist the token
// exports.logoutUser = async (req, res) => {
//   const token = req.headers['authorization'].split(' ')[1];

//   if (!token) {
//     return res.status(400).json({ message: 'Token is required' });
//   }

//   // Add token to Redis (blacklist)
//   redisClient.setex(token, 3600, 'blacklisted', (err) => {
//     if (err) {
//       return res.status(500).json({ message: 'Redis error' });
//     }
//     res.json({ message: 'Logout successful, token invalidated' });
//   });
// };

// // Profile route (same as before)
exports.getUserProfile = async (req, res) => {
  try {
    const { user } = req.authData;
    res.json({ message: 'Profile accessed', user });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};