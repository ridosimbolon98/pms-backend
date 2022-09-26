import express from "express";
import {
  getAllNotif,
  getAllTaskNotif,
  updateStatusNotif,
  updateTaskStatus,
  getAllMyTasks,
  getDBTask
} from "../controllers/Notif.js";
import { verifyUser } from "../middleware/AuthUser.js";

const router = express.Router();

router.get('/tasks', verifyUser, getAllTaskNotif);
router.get('/dbtasks/:uuid', verifyUser, getDBTask);
router.get('/mytasks/:id', verifyUser, getAllMyTasks);
router.patch('/tasks/update/:taskid', verifyUser, updateTaskStatus);
router.get('/notif/:uuid', verifyUser, getAllNotif);
router.patch('/notif/update/:id', verifyUser, updateStatusNotif);

export default router;