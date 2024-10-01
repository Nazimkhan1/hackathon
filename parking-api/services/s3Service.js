const AWS = require('aws-sdk');
const dotenv = require('dotenv');

dotenv.config();
const s3 = new AWS.S3();

exports.uploadToS3 = async (file) => {
  const params = {
    Bucket: process.env.BUCKET_NAME,
    Key: `${Date.now()}_${file.originalname}`,
    Body: file.buffer,
    ContentType: file.mimetype,
  };
  const data = await s3.upload(params).promise();
  return data.Location; // Return the S3 URL
};