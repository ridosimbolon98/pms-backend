import { Sequelize } from "sequelize";
import db from "../config/Database.js";

const {DataTypes} = Sequelize;

const Notifications = db.define('notifications',{
    id:{
        type: DataTypes.STRING,
        primaryKey: true,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    description:{
        type: DataTypes.INTEGER,
        allowNull: false,
        validate:{
            notEmpty: true,
        }
    },
    taskfrom:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    taskto:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    trxtype:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    foreignid:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    read_status:{
        type: DataTypes.BOOLEAN,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    }
},{
    freezeTableName: true,
    schema: 'sc_pms',
});

export default Notifications;