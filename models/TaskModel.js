import { Sequelize } from "sequelize";
import db from "../config/Database.js";
import Projects from "./ProjectModel.js";

const {DataTypes} = Sequelize;

const Tasks = db.define('task',{
    taskid:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    projectid:{
        type: DataTypes.INTEGER,
        allowNull: false,
        validate:{
            notEmpty: true,
        }
    },
    task_name:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    progress:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    bobot:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    pic:{
        type: DataTypes.STRING,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    due_date:{
        type: DataTypes.DATE,
        allowNull: false,
        validate:{
            notEmpty: true
        }
    },
    t_status:{
        type: DataTypes.BOOLEAN,
        allowNull: true,
        validate:{
            notEmpty: true
        }
    },
    startdate:{
        type: DataTypes.DATE,
        allowNull: true
    }
},{
    freezeTableName: true,
    schema: 'sc_pms',
});

export default Tasks;