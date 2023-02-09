import express from "express";
import { 
    dataProjects,
    searchProjects,
    getDept, 
    getNewestProject, 
    getProjectNum, 
    getSubDept 
} from "../controllers/Master.js";
import {
    getProjects,
    allProjects,
    getProjectById,
    createProject,
    updateProject,
    deleteProject,
    getProjectByStatus
} from "../controllers/Projects.js";
import { 
    getTasksByProjectId, 
    getSubTaskByTaskId, 
    closeTaskById,
    createSubTask
} from "../controllers/Tasks.js";
import { verifyUser } from "../middleware/AuthUser.js";

const router = express.Router();

router.get('/projects',verifyUser, getProjects);
router.post('/projects/search',verifyUser, searchProjects);
router.get('/projectstat/:status',verifyUser, getProjectByStatus);
router.get('/tasks/:projectid',verifyUser, getTasksByProjectId);
router.get('/subtasks/:taskid',verifyUser, getSubTaskByTaskId);
router.get('/allprojects',verifyUser, allProjects);
router.get('/dataprojects/:uid',verifyUser, dataProjects);
router.get('/projects/:id',verifyUser,verifyUser, getProjectById);
router.post('/projects',verifyUser, createProject);
router.post('/subtasks',verifyUser, createSubTask);
router.patch('/projects/:id',verifyUser, updateProject);
router.patch('/closetask/:id',verifyUser, closeTaskById);
router.delete('/projects/:id',verifyUser, deleteProject);
router.get('/newestproject',verifyUser, getNewestProject);
router.get('/getprojectnum',verifyUser, getProjectNum);

router.get('/getdept',verifyUser, getDept);
router.get('/getsubdept/:kddept',verifyUser, getSubDept);

export default router;