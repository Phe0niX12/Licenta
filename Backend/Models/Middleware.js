const nodemailer = require('nodemailer');
const { decrypt } = require('../utils/encryption');

const createTransporter = async(req,res,next) =>{
    const {userEmail, userPassword} = req.body;

    if(!userEmail || !userPassword){
        res.status(400).send('User email and password are required');
    }
    try{
        const decryptedPassword = decrypt(userPassword);
        req.transporter = nodemailer.createTransporter({
            service: 'gmail',
            auth: {
                user: userEmail,
                pass: decryptedPassword,
            }
        });
        next();
    }catch(error){
        console.error('Error decrypting password:', error);
        return res.status(500).send('Internal Server Error');
    }
}

module.exports = {createTransporter};