const jwt = require('jsonwebtoken');
const redisClient = require('../config/redis');
const SecretKey = 'SecretKey';

const verifyToken = (req, res, next) => {
    const bearerHeader = req.headers['authorization'];
    if (typeof bearerHeader !== 'undefined') {
        const bearer = bearerHeader.split(' ');
        const token = bearer[1];
        redisClient.get((token, err, data) => {
            if (err) {
                res.status(500).json({ message: "Redis error" });
            }
            if (data) {
                res.status(403).json({ message: "Token has been blacklisted" });
            }
            jwt.verify(token, SecretKey, (err, authData) => {
                if (err) {
                    res.status(403).json({ message: "Invalid Token" });
                } else {
                    req.authData = authData;
                    next();
                }
            });
        });

    } else {
        res.status(403).json({ message: "Token not provided" });
    }
}



module.exports = verifyToken;

