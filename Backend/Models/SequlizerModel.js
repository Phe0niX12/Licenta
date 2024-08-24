

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
        type:DataTypes.STRING,
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
});

User.hasMany(Emails);
User.hasMany(Tasks);


sequelize.sync({force:false})

module.exports = {User,Emails,Tasks,sequelize};

