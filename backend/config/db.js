const mysql = require('mysql2');
const con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "123456",
    database: "students"
})

con.connect((err) => {
    if (err) {
        console.log(`Error while connecting database ${err}`);
        return;
    } else {
        console.log(`Connection created successfully`);
    }
})

module.exports = con;