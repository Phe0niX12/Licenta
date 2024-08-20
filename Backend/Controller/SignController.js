const {User} = require('../Models/SequlizerModel')
const bcrypt = require('bcrypt')
const {v4:uuidv4} = require('uuid')
const sign_in = async(req, res) =>{
    try{
        const {password, email} = req.body;
        const user = await User.findOne({
            where:{
                email:email,
            }
        }) 
        if(!user){
            return res.status(404).send('User not found');

        }
        const passwordValid = await bcrypt.compare(password, user.password)
        if(!passwordValid){
            return res.status(402).send('Incorrect email or password');
        }
        res.send({
            username:user.username,
            email:user.email
        })
    }catch(e){
        console.log(e);
        return res.status(500).send('Unexpected error at login')
    }
}

const sign_up = async(req,res) =>{
    try{
        const id = uuidv4();
        const {username,password, email} = req.body;
        const userExists = await User.findOne({
            where:{
                email:email,
            }
        });
        if(userExists){
            return res.status(500).send('Email is already associated with an account');
        }
        await User.create({
            id:id,
            username:username,
            password: await bcrypt.hash(password,15),
            email:email
        });
        return res.status(200).send('Registration successful')
    }catch(err){
        console.log(err);
        res.status(500).send('Unexpected error in registering user');
    }
}

const authenticate = async(req,res,next) =>{
    try{
        const email = req.headers.authorization
        
        const user = await User.findOne({
            where:{
                email:email
            }
        })
        
        if(!user){
            return res.status(404).send('No account with this email was found');
        }
        req.userid = user.id
        req.username =user.username
        next();
    }catch(err){
        
        return res.status(500).send('Unexpected error at authentification')
    }
}
module.exports = {sign_in,sign_up,authenticate};