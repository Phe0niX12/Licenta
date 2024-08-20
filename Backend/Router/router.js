const express = require('express')
const {sign_in, sign_up,authenticate} = require('../Controller/SignController.js');
const {deleteTask,getOneTask,getAllTasksOfUser,createTask,updateTask} = require('../Controller/TaskController.js')
const {createEmail,getAllEmails,getOneEmail,deleteEmail,updateEmail} = require('../Controller/EmailController.js');
const {createVirtualWallet} = require('../Controller/WalletController.js');
const {createTransporter} = require('../Models/Middleware.js')
const router = express.Router();

router.post('/sign_in', sign_in);
router.post('/sign_up', sign_up);

router.get('/tasks',authenticate,getAllTasksOfUser);
router.post('/task',authenticate,createTask);
router.put('/task/:id', authenticate, updateTask);
router.get('/task/:id',authenticate,getOneTask);
router.delete('/task/:id',authenticate,deleteTask);

router.post('/email',authenticate,createEmail);
router.get('/emails',authenticate,getAllEmails);
router.get('/email/:id',authenticate,getOneEmail);
router.delete('/email/:id',authenticate,deleteEmail);
router.put('/email/:id',authenticate,updateEmail);

router.post('/wallet', authenticate,createVirtualWallet);
module.exports = {router}

