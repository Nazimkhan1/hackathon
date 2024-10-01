// controllers/userController.js
const Receipt = require('../models/receiptModel');
const jwt = require('jsonwebtoken');
const redisClient = require('../config/redis');
const secretKey = 'secretKey';

// Get all users

exports.receiptList = (req, res) => {
    Receipt.getReceiptUsers(searchMonth, (err, receipts) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            const response = {
                status_code: 1,
                message: 'All receipt user list',
                data: receipts
            };
        
            res.status(202).json(response);
        }
    });
};


exports.userReceiptList = (req, res) => {
    const User = req.body;
    //console.log(User); return false;
    Receipt.getUserReceipts(User.user_id, (err, receipts) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            const response = {
                status_code: 1,
                message: 'User receipt list',
                data: receipts
            };
        
            res.status(202).json(response);
        }
    });
};

