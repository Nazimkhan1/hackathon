const db = require('../config/db');

exports.getReceiptUsers = (searchMonth, callback) => {
    db.query("select * from user_receipts", (err, res) => {
        if (err) return callback(err);
        callback(null, res)
    });
};



exports.getUserReceipts = (user_id, callback) => {
    db.query("select * from user_receipts where user_id = ?", user_id, (err, res) => {
        if (err) return callback(err);
        callback(null, res);
    });
};

exports.saveReceipt = (userData, callback) => {

   
    db.query('INSERT INTO user_receipts SET ?', userData, (err, result) => {
        if (err) return callback(err);
        callback(null, result.insertId);
    });
};




