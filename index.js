import express from "express";
import cors from "cors";
import session from "express-session";
import dotenv from "dotenv";
import db from "./config/Database.js";
import SequelizeStore from "connect-session-sequelize";
import UserRoute from "./routes/UserRoute.js";
import ProjectRoute from "./routes/ProjectRoute.js";
import AuthRoute from "./routes/AuthRoute.js";
import TaskRoute from "./routes/TaskRoute.js";
import ToolsRoute from "./routes/ToolsRoute.js";
import fileUpload from "express-fileupload";
dotenv.config();

const app = express();

const sessionStore = SequelizeStore(session.Store);

const store = new sessionStore({
    db: db
});


// (async()=>{
//     await db.sync();
// })();

app.use(session({
    secret: process.env.SESS_SECRET,
    resave: false,
    saveUninitialized: true,
    store: store,
    cookie: {
        secure: 'auto'
    }
}));


app.use(cors({
    credentials: true, 
    origin: ["http://192.168.10.9:4000", "http://192.168.10.13:8346", "http://192.168.10.30:3000", "http://192.168.10.30"]
}));

app.use(fileUpload());


// app.use((req, res, next) => {
// 	 const corsWhitelist = [
//         'http://192.168.10.9:4000',
//         'http://192.168.10.13:8346',
//         'http://103.247.123.64:8346',
// 		'http://192.168.10.30:3000'
//     ];
//     if (corsWhitelist.indexOf(req.headers.origin) !== -1) {
// 		res.header("Access-Control-Allow-Credentials", true);
//         res.header('Access-Control-Allow-Origin', req.headers.origin);
//         res.header('Access-Control-Allow-Method', 'GET, POST, PATCH, PUT, DELETE, OPTIONS');
//         res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
//     }
//     next();
// });

app.use(express.json());
app.use(UserRoute);
app.use(ProjectRoute);
app.use(AuthRoute);
app.use(TaskRoute);
app.use(ToolsRoute);

// store.sync();

app.listen(process.env.APP_PORT, ()=> {
    console.log(`Server up and running at PORT: ${process.env.APP_PORT}`);
});