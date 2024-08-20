

require("dotenv").config;

const { Sequelize,DataTypes} = require("sequelize");


const sequelize = new Sequelize(process.env.DB_NAME, 'root',process.env.DB_PASSWORD,{
    host:process.env.DB_HOST,
    dialect:'mysql',
    port:process.env.DB_PORT
})

sequelize.authenticate()
    .then(()=>{
        console.log('Connection succesful')
    }).catch(error =>{
        console.error('Unable to conncet to database:', error)
    })
const User = sequelize.define("User",{
    id:{
        type:DataTypes.UUID,
        defaultValue:Sequelize.UUIDV4,
        allowNull:false,
        validate:{
            notEmpty:true
        },
        primaryKey:true
    },
    username:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        },
        unique:true
    
    },
    password:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true,
            
        },
    },
    email:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true,
            is: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i
        },
        unique:true
    }
});

const Emails = sequelize.define("Emails",{
    id:{
        type:DataTypes.UUID,
        defaultValue:Sequelize.UUIDV4,
        validate:{
            notEmpty:true
        },
        primaryKey:true
    },
    to:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true,
            is: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i
        }
    },
    cc:{
        type:DataTypes.STRING,
        allowNull:true,
        validate:{
            is: /^$|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i
        }
        
    },
    bcc:{
        type:DataTypes.STRING,
        allowNull:true,
        validate:{
            is: /^$|[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/i
        }
        
    },
    subject:{
        type:DataTypes.STRING,
        allowNull:false
    },
    content:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    dateAndTimeSend:{
        type:DataTypes.DATE,
        allowNull:false,
        validate:{
            notEmpty:true,
            customValidator(value){
                if(new Date(value) < new Date())
                    throw new Error("invalid date")
            }
        }
    },
    send:{
        type:DataTypes.BOOLEAN,
        allowNull:false,
    },
    dateAndTimeReminder:{
        type:DataTypes.DATE,
        allowNull:false,
        validate:{
            notEmpty:true,
            customValidator(value){
                if(new Date(value) < new Date())
                    throw new Error("invalid date")
            }
        }
    },
    reminderSend:{
        type:DataTypes.BOOLEAN,
        allowNull:false
    },
    responseReceived:{
        type:DataTypes.BOOLEAN,
        allowNull:false
    },
    userEmail:{
        type:DataTypes.STRING,
        allowNull:false,
    },
    userPassword:{
        type:DataTypes.STRING,
        allowNull:false
    }
});
const Tasks = sequelize.define("Tasks",{
    id:{
        type:DataTypes.UUID,
        defaultValue:Sequelize.UUIDV4,
        validate:{
            notEmpty:true
        },
        primaryKey:true
    },
    name:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    description:{
        type:DataTypes.STRING,
        allowNull:false,

    },
    reminderDateTime:{
        type:DataTypes.DATE,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
});

const VirtualWallets = sequelize.define("VirtualWallets",{
    id:{
        type:DataTypes.UUID,
        defaultValue:Sequelize.UUIDV4,
        validate:{
            notEmpty:true
        },
        primaryKey:true
    },
    walletAddress:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    walletProvateKey:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    walletAddressIv:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    walletProvateKeyIv:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    
})

const Payments = sequelize.define("Payments",{
    id:{
        type:DataTypes.UUID,
        defaultValue:Sequelize.UUIDV4,
        validate:{
            notEmpty:true
        },
        primaryKey:true
    },
    recipientAddress:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    amount:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    schedule:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    },
    status:{
        type:DataTypes.STRING,
        allowNull:false,
        validate:{
            notEmpty:true
        }
    }
})
User.hasMany(Emails);
User.hasOne(VirtualWallets);
User.hasMany(Tasks);
VirtualWallets.hasMany(Payments);

sequelize.sync({force:false})

module.exports = {User,Payments,VirtualWallets,Emails,Tasks,sequelize};

