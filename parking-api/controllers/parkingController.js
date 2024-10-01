// Load environment variables from .env file
require('dotenv').config();

const { S3Client } = require('@aws-sdk/client-s3');
const multer = require('multer');
const multerS3 = require('multer-s3');
const Receipt = require('../models/receiptModel');

// Create an S3 client using the credentials and region from the environment
const s3 = new S3Client({
  region: process.env.AWS_REGION,
  credentials: {
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
  },
});

// Configure Multer to use S3 as the storage engine
const upload = multer({
  storage: multerS3({
    s3: s3,
    bucket: process.env.BUCKET_NAME,  // Bucket name only
    key: function (req, file, cb) {
      const folderName = 'parkingBill/';  // Specify the folder name
      const filePath = `${folderName}${file.originalname}`;  // Create the file path
      cb(null, filePath);  // Store the file in the "parkingBill" folder
    },
  }),
}).single('file');  // Assuming 'file' is the name of the input field

// Function to handle the parking bill upload and save
exports.saveParkingBill = async (req, res) => {
   // const { amount } = req.body;
  //  console.log(amount); return false;
  // Use multer's upload function to handle the file upload
  upload(req, res, (err) => {
    

    if (err) {
      console.error('Error during file upload:', err);
      return res.status(500).send('File upload failed.');
    }

    console.log(req.body.user_id);


    if (!req.file) {
      return res.status(400).send('No file uploaded.');
    }

   
    // Construct the S3 file path for the response
    const filePath = `https://${process.env.BUCKET_NAME}.s3.${process.env.AWS_REGION}.amazonaws.com/${req.file.key}`;

    const amount = req.body.amount;
    const vehicle_type = req.body.vehicle_type;
    const user_id = req.body.user_id;
    const receiptData = { 
     "user_id":user_id,
     "vehicle_type":vehicle_type,
     "amount":amount,
     "receipt_file":filePath,
 
    };



    Receipt.saveReceipt(receiptData, (err, receipts) => {
        if (err) {
            res.status(500).json({ error: err.message });
        } else {
            const response = {
                status_code: 1,
                message: 'Receipt Save Successfully',
                data: receipts
            };
        
            res.status(202).json(response);
        }
    });
   
  });
};