import Project from "../models/ProjectModel.js";
import Tasks from "../models/TaskModel.js";
import Notifications from "../models/Notifications.js";

export const allProjects = async (req, res) =>{
    try {
        let response = await Project.findAll();
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getProjects = async (req, res) =>{
    try {
        let response;
        if(req.role === "admin"){
            response = await Project.findAll();
        }else{
            response = await Project.findAll();
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getProjectById = async(req, res) =>{
    try {
        const project = await Project.findOne({
            where:{
                projectid: req.params.id
            }
        });
        if(!project) return res.status(404).json({msg: "Data tidak ditemukan"});
        let response;
        if(req.role === "admin"){
            response = await Project.findOne({
                where:{
                    id: project.id
                }
            });
        }else{
            response = await Project.findOne({
                attributes:['uuid','name','price'],
                where:{
                    id: project.id
                }
            });
        }
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getProjectByStatus = async(req, res) =>{
    try {
        const project = await Project.findAll({
            where:{
                status: req.params.status
            }
        });
        if(!project) return res.status(404).json({msg: "Data tidak ditemukan"});
        res.status(200).json(project);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const createProject = async(req, res) =>{
    const {projectname, description, bagdept, subbagdept, participant, location, ttlitem, ttlbobot, startproj, endproj, status, inputby, uid} = req.body;
    const projectid = Date.now();
    try {
        await Project.create({
            projectid: projectid,
            projectname: projectname,
            description: description,
            bagdept: bagdept,
            subbagdept: subbagdept,
            pic: participant,
            location: JSON.stringify(location),
            ttlitem: ttlitem,
            ttlbobot: ttlbobot,
            startproj: startproj,
            endproj: endproj,
            status: status,
            inputby: inputby
        });

        let task_id = Date.now();
        for (let index = 0; index < location.length; index++) {
            Tasks.create({
                taskid: task_id + index,
                projectid: projectid,
                task_name: location[index].task,
                progress: 0,
                bobot: location[index].bobot,
                pic: location[index].pic.value,
                due_date: location[index].duedate,
                t_status: false,
                startdate: location[index].startdate
            });

            let nid = 'ND'+Date.now()+index;

            Notifications.create({
                id: nid,
                description: 'New Task' +': '+ location[index].task + '. Project ID: '+ projectid,
                taskfrom: uid,
                taskto: location[index].pic.uid,
                trxtype: 'New Task',
                foreignid: projectid,
                read_status: false
            });
        }
        res.status(201).json({msg: "Project Created Successfuly"});
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const updateProject = async(req, res) =>{
    try {
        const project = await Project.findOne({
            where:{
                projectid: req.params.id
            }
        });
        if(!project) return res.status(404).json({msg: "Data tidak ditemukan"});
        const {projectname, description, bagdept, subbagdept, pic, location, ttlitem, ttlbobot, startproj, endproj, status, inputby} = req.body;
        if(req.role === "admin"){
            await Project.update({projectname, description, bagdept, subbagdept, pic, location, ttlitem, ttlbobot, startproj, endproj, status, inputby},{
                where:{
                    id: project.id
                }
            });
        }else{
            if(req.userId !== project.userId) return res.status(403).json({msg: "Akses terlarang"});
            await Project.update({projectname, description, bagdept, subbagdept, pic, location, ttlitem, ttlbobot, startproj, endproj, status, inputby},{
                where:{
                    id: project.id
                }
            });
        }
        res.status(200).json({msg: "Project updated successfuly"});
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const deleteProject = async(req, res) =>{
    try {
        const project = await Project.findOne({
            where:{
                projectid: req.params.id
            }
        });
        if(!project) return res.status(404).json({msg: "Data tidak ditemukan"});
        const {name, price} = req.body;
        if(req.role === "admin"){
            await Project.destroy({
                where:{
                    id: project.id
                }
            });
        }else{
            if(req.userId !== project.userId) return res.status(403).json({msg: "Akses terlarang"});
            await Project.destroy({
                where:{
                    id: project.id
                }
            });
        }
        res.status(200).json({msg: "Project deleted successfuly"});
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}