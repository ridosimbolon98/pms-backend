import express from "express";
import {
    uploadFile,
} from "../controllers/Tools.js";

const router = express.Router();

router.post('/tools/upload', uploadFile);

export default router;