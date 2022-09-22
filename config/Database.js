import {Sequelize} from "sequelize";

const db = new Sequelize('KC', 'postgres', 'Masteritnbi1', {
    host: "192.168.10.13",
    port: '5432',
    dialect: "postgres"
});

export default db;