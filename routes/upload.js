import fs from "fs";
import dotenv from "dotenv";
import path from "path";
import generateData from "../util/image_text.js";
dotenv.config()

const _dirname = path.resolve();
const uploadFolder = path.join(_dirname,"uploads");
fs.mkdirSync(uploadFolder,{recursive:true})

const upload = async (req,res)=>{
    const imageUrl = `${uploadFolder}/${req.file.path.split("/")[1]}`;
    try{
        const data = await generateData(imageUrl,req.file.mimetype);
       await fs.unlinkSync(imageUrl);
    return res.json(data);
    }catch(err){
        return res.json({error:err})
    }
}

export default upload;