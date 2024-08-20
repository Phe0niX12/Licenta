const {VirtualWallets} =require('../Models/SequlizerModel')
const {v4:uuidv4} = require('uuid')
const {createWallet} = require('../Wallet/Wallet')

const createVirtualWallet = async(req,res)=>{
    try{
        const wallet = createWallet();
        console.log(wallet);
        res.json(wallet);
    }catch(err){
        return res.status(500).send({err,message:'Unexpected error at creating wallet'});
    }
}

module.exports = {createVirtualWallet};