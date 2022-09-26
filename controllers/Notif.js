import pool from "../config/Queries.js";
import moment from "moment-timezone";

export const getAllTaskNotif = async (req, res) =>{
  try {
      let response = await pool.query(
        `select a.taskid,a.projectid,a.task_name,a.progress,a.pic,a.startdate,a,due_date,a.t_status,b.projectname
        from sc_pms.task a left outer join sc_pms.project b
        on a.projectid=b.projectid
        order by a.projectid asc, a.task_name asc`
      );
      res.status(200).json(response.rows);
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}

export const getAllMyTasks = async (req, res) =>{
  try {
      let response = await pool.query(
        `select a.taskid,a.projectid,a.task_name,a.progress,a.pic,a.startdate,a,due_date,a.t_status,b.projectname
        from sc_pms.task a left outer join sc_pms.project b
        on a.projectid=b.projectid
        left outer join sc_pms.users c
        on cast(a.pic as integer)=c.id
        where c.id='${req.params.id}'
        order by a.projectid asc, a.task_name asc`
      );
      res.status(200).json(response.rows);
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}

export const getAllNotif = async (req, res) =>{
  try {
      let response = await pool.query(
        `select a.id, a.description, a.read_status, a.trxtype, a.foreignid, a."createdAt", b.name
          from sc_pms.notifications a left outer join sc_pms.users b 
          on a.taskfrom=b.uuid 
          where a.taskto='${req.params.uuid}'`
      );
      res.status(200).json(response.rows);
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}

export const updateStatusNotif = async (req, res) =>{
  try {
    let updatedat = moment.tz(Date.now(), "Asia/Jakarta").format();
    let response = await pool.query(
      `update sc_pms.notifications set read_status='true', "updatedAt"='${updatedat}' where id='${req.params.id}'`
    );
    if (response) {
      res.status(200).json(response);
    }
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}

export const updateTaskStatus = async (req, res) =>{
  try {
    let updatedat = moment.tz(Date.now(), "Asia/Jakarta").format();
    let response = await pool.query(
      `update sc_pms.task set t_status='true', "updatedAt"='${updatedat}' where taskid='${req.params.taskid}'`
    );
    console.log(response);
    if (response) {
      res.status(200).json(response);
    }
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}

export const getDBTask = async (req, res) =>{
  try {
      let response = await pool.query(
        `select a.description, a.trxtype, a.foreignid as projectid, a.read_status, a."createdAt", a.taskfrom, b.name from sc_pms.notifications a
        left join sc_pms.users b on a.taskfrom=b.uuid
        where a.read_status='false' and a.taskto='${req.params.uuid}' 
        order by a."createdAt" desc 
        limit(4)`
      );
      res.status(200).json(response.rows);
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}