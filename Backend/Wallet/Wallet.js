const { ethers } = require('ethers');
require('dotenv').config

// // Provider configuration for Ganache
const ganacheUrl = process.env.NETWORK ||'http://127.0.0.1:7545'; // Update URL if Ganache is running on a different port
const provider = new ethers.providers.JsonRpcProvider(ganacheUrl);

const createWallet = async()=>{
    try{
        const wallet = await ethers.Wallet.createRandom();
        console.log(wallet);
        return wallet;
    }catch(err){
        return
    }

}

module.exports= {createWallet};

// // Function to send Ether from one Ganache account to another wallet
// const sendEther = async (senderPrivateKey, recipientAddress, amount) => {
//   // Create sender wallet from private key
//   const senderWallet = new ethers.Wallet(senderPrivateKey, provider);

//   // Convert amount to BigNumber
//   const value = ethers.utils.parseEther(amount);

//   // Send transaction
//   const tx = await senderWallet.sendTransaction({
//     to: recipientAddress,
//     value: value,
//     gasLimit:ethers.utils.hexlify(21000),
//     gasPrice:ethers.utils.parseUnits('20', 'gwei') 
//   });

//   // Wait for transaction confirmation
//  const receipt =await tx.wait();
//   const gasUsed = receipt.gasUsed;
//   console.log('Transaction sent:', tx.hash, '\nGas used:', gasUsed.toString());
// };

// const getBalance = async (address) => {
//     const balance = await provider.getBalance(address);
//     return ethers.utils.formatEther(balance);
//   };

// // Example usage

// (async () => {
//   try {
//     // Get list of accounts provided by Ganache
//     const accounts = await provider.listAccounts();

//     // Select a sender account from Ganache
//     const senderAddress = accounts[0]; // Using the first account for simplicity
//     const senderPrivateKey = "0x44732ec0ff434c89a0f1552c382e27fd6b3ad411e4b6e83cb1b96ff94e9d013f";
//     console.log('this is the senderaAddress:',senderAddress)
//     // Generate ethers.js wallet (recipient)
//     const ethersWallet = ethers.Wallet.createRandom();
//     console.log('Ethers.js Wallet Address:', ethersWallet.address);

//     // Send Ether from Ganache account to ethers.js wallet
//     console.log('Sending Ether from Ganache account to ethers.js wallet...');
//     let testEther = '0.01'; // 0.1 ETH
//     await sendEther(senderPrivateKey, ethersWallet.address, testEther);
//     testEther = '0.000001';

//     // Send Ether back from ethers.js wallet to Ganache account
//     // console.log('Sending Ether back from ethers.js wallet to Ganache account...');
//     // await sendEther(ethersWallet.privateKey, senderAddress, testEther);
//     const balance =await getBalance(senderAddress);
//     console.log(balance);
//   } catch (error) {
//     console.error('Error:', error);
//   }
// })();


