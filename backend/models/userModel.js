const db = require('../config/db');

exports.getAllUsers = (callback) => {
    db.query("select * from student_details", (err, res) => {
        if (err) return callback(err);
        callback(null, res)
    });
};

exports.getUserById = (id, callback) => {
    db.query("select * from student_details where id = ?", id, (err, res) => {
        if (err) return callback(err);
        callback(null, res[0]);
    });
};

// Create a new user
exports.createUser = (userData, callback) => {
    db.query('INSERT INTO users SET ?', userData, (err, result) => {
        if (err) return callback(err);
        callback(null, result.insertId);
    });
};

// Update a user by ID
exports.updateUser = (id, userData, callback) => {
    db.query('UPDATE users SET ? WHERE id = ?', [userData, id], (err, result) => {
        if (err) return callback(err);
        callback(null, result.affectedRows);
    });
};

// Delete a user by ID
exports.deleteUser = (id, callback) => {
    db.query('DELETE FROM users WHERE id = ?', [id], (err, result) => {
        if (err) return callback(err);
        callback(null, result.affectedRows);
    });
};

//Get user by Email
exports.getUserByEmail = (email, callback) => {
    db.query('select * from student_details where email=?', [email], (err, result) => {
        if (err) return callback(err)
        //console.log(result);
        callback(null, result[0]);
    });
}