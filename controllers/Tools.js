import path, { dirname } from 'path';
export const uploadFile = async (req, res) =>{
  try {
    const __dirname = './upload_convert';
    console.log(path);
    console.log(__dirname);
      // const filename = req.files.convertfile.name;
      // const filecvt = req.files.convertfile;
      // let uploadPath = __dirname +"/upload_convert/"+ filename;
      // filecvt.mv(uploadPath, (err) => {
      //   if (err) {
      //     return res.send(err);
      //   }
      // });

      res.status(200);
  } catch(error){
      res.status(500).json({msg: error.message});
  }
}
