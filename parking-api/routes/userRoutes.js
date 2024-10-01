const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const verifyToken = require('../middleware/authMiddleware');

// Define the routes for users

router.get('/users', userController.getAllUsers);
router.get('/users/:id', userController.getUserById);
router.post('/users', userController.createUser);
router.put('/users/:id', userController.updateUser);
router.delete('/users/:id', userController.deleteUser);
router.post('/login', userController.loginUser);
router.get('/profile', verifyToken, userController.getUserProfile);
// router.post('/logout', verifyToken, userController.logoutUser);

router.post('/loginPost', userController.loginPost);

module.exports = router;