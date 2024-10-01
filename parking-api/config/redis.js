// config/redis.js
const redis = require('redis');

// Create a Redis client
const client = redis.createClient({
    legacyMode:true,
    host: '127.0.0.1',
    port: 6379 // Default Redis port
});

client.on('connect', () => {
    console.log('Connected to Redis');
});

client.on('error', (err) => {
    console.log('Redis error: ', err);
});

module.exports = client;
