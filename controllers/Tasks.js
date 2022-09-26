import pool from "../config/Queries.js";
import moment from "moment-timezone";
import Tasks from "../models/TaskModel.js";
import Notifications from "../models/Notifications.js";

export const insertNewTask = async(req, res) =>{
    const {projectid, taskdesc, taskbobot, startdate, duedate, pic, from} = req.body;
    const taskid = Date.now();
    try {
        let user = await pool.query(
            `select uuid from sc_pms.users where id='${pic.value}'` 
        );

        await Tasks.create({
            taskid: taskid,
            projectid: projectid,
            task_name: taskdesc,
            progress: 0,
            bobot: taskbobot,
            pic: pic.value,
            due_date: duedate,
            t_status: false,
            startdate: startdate
        });

        let nid = 'ND'+Date.now();

        Notifications.create({
            id: nid,
            description: 'New Task' +': '+ taskdesc + '. Project ID: '+ projectid,
            taskfrom: from,
            taskto: user.rows[0].uuid,
            trxtype: 'New Task',
            foreignid: projectid,
            read_status: false
        });
        res.status(201).json({msg: "New Task Created Successfuly"});
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getTasksByProjectId = async (req, res) =>{
    try {
        let response = await pool.query(
          `select 
                a.projectname, 
                a.description, 
                a.startproj, 
                a.subbagdept, 
                a.pic as partisipant,
                a.status,
                a.projectid,
                b.id,
                b.taskid,
                b.task_name,
                b.progress,
                b.bobot,
                b.pic,
                b.due_date,
                b.t_status,
                b.startdate,
                c.name
            from sc_pms.project a left outer join sc_pms.task b 
            on a.projectid=b.projectid 
            left outer join sc_pms.users c
            on cast(b.pic as integer)=c.id
            where a.projectid='${req.params.projectid}' 
            order by taskid asc`
        );
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getSubTaskByTaskId = async (req, res) =>{
    try {
        let response = await pool.query(
          `select 
                a.*, 
                b.*,
                c.name 
          from sc_pms.task a 
          left join sc_pms.sub_task b 
          on a.taskid=b.taskid 
          left join sc_pms.users c
          on cast(b.pic as integer)=c.id
          where a.taskid='${req.params.taskid}' 
          order by b."createdAt" desc`
        );
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const closeTaskById = async (req, res) =>{
    try {
        let response = await pool.query(
          
        ` update sc_pms.task set t_status='true', progress='100' where taskid='${req.params.id}';
          update sc_pms.project set 
          ttlbobot=(
              select sum(bobot::int) 
              from sc_pms.task 
              where progress='100' and projectid=(select projectid 
                                                  from sc_pms.task 
                                                  where taskid='${req.params.id}')
          ),
          startproj=(
              select min(startdate) 
              from sc_pms.task 
              where projectid=(select projectid 
                               from sc_pms.task 
                               where taskid='${req.params.id}')
          ),
          endproj=(
              select max(due_date) 
              from sc_pms.task 
              where projectid=(select projectid 
                               from sc_pms.task 
                               where taskid='${req.params.id}')
          )
          where projectid=(select projectid 
                           from sc_pms.task 
                           where taskid='${req.params.id}');
          update sc_pms.project 
          set status = case
                      when (ttlbobot::int)='100' then 'CLOSE'
                      when (ttlbobot::int)<'100' then 'OPEN'
                  end
          where projectid=(select projectid
                           from sc_pms.task 
                           where taskid='${req.params.id}');`
        );
        res.status(200).json(response);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getUid = async (req, res) =>{
    try {
        var pic = req.body.pic;
        const uuidUser = await pool.query(
            `select uuid from sc_pms.users where id=cast(${pic} as integer)`
        );
        let to = uuidUser.rows[0].uuid;
        res.status(200).json(uuidUser.rows);
    } catch(error){
        res.status(500).json({msg: error.message});
    }
}

export const createSubTask = async (req, res) =>{
    try {
        var subtaskid = Date.now();
        var createdat = moment.tz(Date.now(), "Asia/Jakarta").format();
        var updatedat = moment.tz(Date.now(), "Asia/Jakarta").format();
        var subtask = req.body.subtask;
        const taskid = req.body.taskid;
        var pic = req.body.pic;
        var pid = req.body.pid;
        var from = req.body.from;

        const uuidUser = await pool.query(
            `select uuid, name from sc_pms.users where id=cast(${pic} as integer)`
        );

        // set data notification
        let idNotif = 'ND'+Date.now();
        let type = "New Sub Task";
        let description = type +': '+ subtask + '. Project ID: '+ pid;
        let to = uuidUser.rows[0].uuid;
        let read = false;

        const insert = await pool.query(
            `INSERT INTO sc_pms.sub_task(subtaskid, taskid, subtask_name, pic, "createdAt", "updatedAt") 
            VALUES('${subtaskid}','${taskid}','${subtask}','${pic}','${createdat}','${updatedat}');
            INSERT INTO sc_pms.notifications(id, description, taskfrom, taskto, trxtype, foreignid, read_status, "createdAt", "updatedAt") VALUES('${idNotif}', '${description}', '${from}', '${to}', '${type}', '${pid}', '${read}', '${createdat}', '${updatedat}');`
        );
        res.status(201).json({msg: "Sub Task Added Successfuly"});
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}
