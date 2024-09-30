const express = require('express');
const router = express.Router();
const mainApiController = require('../controllers/mainApiController');

router.get('/get-data', mainApiController.getData);
router.post('/post-data', mainApiController.postData);

module.exports = router;