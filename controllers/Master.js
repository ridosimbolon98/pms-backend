import pool from "../config/Queries.js";

export const getDept = async (req, res) =>{
    try {
        let response = await pool.query(
          `select trim(kddept) as kddept, nmdept from sc_mst.departmen order by kddept asc`
        );
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getSubDept = async (req, res) =>{
    try {
        let response = await pool.query(
          `select trim(kddept) as kddept ,trim(kdsubdept) as kdsubdept, nmsubdept from sc_mst.subdepartmen where kddept='${req.params.kddept}' order by kdsubdept asc`
        );
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getNewestProject = async (req, res) =>{
    try {
        let response = await pool.query(
          `select trim(projectid) as projectid, projectname, ttlbobot, status from sc_pms.project order by "createdAt" desc limit (5)`
        );
        res.status(200).json(response.rows);
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}

export const getProjectNum = async (req, res) =>{
    try {
        // jumlah semua project
        let all_pn = await pool.query(
          `select count(*) as proj_num from sc_pms.project`
        );

        // jumlah project open
        let open_pn = await pool.query(
          `select count(*) as proj_num from sc_pms.project where status='OPEN'`
        );
        
        // jumlah project closed
        let closed_pn = await pool.query(
          `select count(*) as proj_num from sc_pms.project where status='CLOSED'`
        );
        
        // jumlah project pending
        let pending_pn = await pool.query(
          `select count(*) as proj_num from sc_pms.project where status='PENDING'`
        );
        
        res.status(200).json({
            "all_pn": all_pn.rows,
            "open_pn": open_pn.rows,
            "closed_pn": closed_pn.rows,
            "pending_pn": pending_pn.rows
        });
    } catch (error) {
        res.status(500).json({msg: error.message});
    }
}


export const dataProjects = async (req, res) =>{
  let uid = req.params.uid;
  try {
      let response = await pool.query(
        `select trim(projectid) as projectid, projectname, ttlbobot, status from sc_pms.project order by "createdAt" desc limit (5)`
      );
      res.status(200).json(response.rows);
  } catch (error) {
      res.status(500).json({msg: error.message});
  }
}
