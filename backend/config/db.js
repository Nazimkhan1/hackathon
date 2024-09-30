const mysql = require('mysql2');
const con = mysql.createConnection({
    host: "non-prod-mep-green-mol6kz.cluster-cefmhl7ts69d.ap-south-1.rds.amazonaws.com",
    user: "nextiasproddb",
    password: "TiGER#123",
    database: "next_ias_uat"
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