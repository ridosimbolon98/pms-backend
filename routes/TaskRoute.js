import express from "express";
import {
  getAllNotif,
  getAllTaskNotif,
  updateStatusNotif,
  updateTaskStatus,
  deleteTask,
  getAllMyTasks,
  getDBTask
} from "../controllers/Notif.js";
import { 
  insertNewTask,
  taskDetails,
  updateTaskName
} from "../controllers/Tasks.js";
import { verifyUser } from "../middleware/AuthUser.js";

const router = express.Router();

router.get('/tasks', verifyUser, getAllTaskNotif);
router.post('/tasks', verifyUser, insertNewTask);
router.get('/dbtasks/:uuid', verifyUser, getDBTask);
router.get('/mytasks/:id', verifyUser, getAllMyTasks);
router.patch('/tasks/update/:taskid', verifyUser, updateTaskStatus);
router.patch('/taskupdate', verifyUser, updateTaskName);
router.delete('/tasks/:taskid', verifyUser, deleteTask);
router.get('/taskdetail/:taskid', verifyUser, taskDetails);
router.get('/notif/:uuid', verifyUser, getAllNotif);
router.patch('/notif/update/:id', verifyUser, updateStatusNotif);

export default router;