import express from "express";
import { getUid } from "../controllers/Tasks.js";
import {
    getUsers,
    getUserById,
    createUser,
    updateUser,
    deleteUser,
    getUserByEmail
} from "../controllers/Users.js";
import { verifyUser, adminOnly } from "../middleware/AuthUser.js";

const router = express.Router();

router.get('/users', verifyUser, getUsers);
router.get('/users/:id', verifyUser, adminOnly, getUserById);
router.post('/cekuser', verifyUser, adminOnly, getUserByEmail);
router.post('/users', verifyUser, adminOnly, createUser);
router.post('/create_user', verifyUser, adminOnly, createUser);
router.patch('/users/:id', verifyUser, adminOnly, updateUser);
router.delete('/users/:id', verifyUser, adminOnly, deleteUser);
router.post('/getuid', getUid);

export default router;