import axios from "axios";
import fs from "fs";
import path from "path";

const _dirname = path.resolve();
const uploadFolder = path.join(_dirname,"uploads");
fs.mkdirSync(uploadFolder,{recursive:true})

const upload = {
    initialPrompt: async (req,res)=>{
        const imageUrl = `http://${req.headers.host}/${req.file.path.split("\\")[1]}`;
        const deleteImage = `${uploadFolder}\\${req.file.path.split("\\")[1]}`;
        try{
            const response = await axios.post('http://127.0.0.1:5000/initialPrompt',{data:{
                "imageUrl":`${imageUrl}`       }})
                await fs.unlinkSync(deleteImage);
                return res.json(response.data);
            }catch(err){
                await fs.unlinkSync(deleteImage);
            return res.json({error:err})
        }
    },
    ratioPrompt: async (req,res)=>{
        const imageUrl = `http://${req.headers.host}/${req.file.path.split("\\")[1]}`;
        const deleteImage = `${uploadFolder}\\${req.file.path.split("\\")[1]}`;
        try{
            const response = await axios.post('http://127.0.0.1:5000/ratioPrompt',{data:{
                "imageUrl":`${imageUrl}`       }})
                await fs.unlinkSync(deleteImage);
                return res.json(response.data);
            }catch(err){
                await fs.unlinkSync(deleteImage);
            return res.json({error:err})
        }
    },
    healthPrompt: async (req,res)=>{
        const imageUrl = `http://${req.headers.host}/${req.file.path.split("\\")[1]}`;
        const deleteImage = `${uploadFolder}\\${req.file.path.split("\\")[1]}`;
        try{
            const response = await axios.post('http://127.0.0.1:5000/healthPrompt',{data:{
                "imageUrl":`${imageUrl}`       }})
                await fs.unlinkSync(deleteImage);
                return res.json(response.data);
            }catch(err){
                await fs.unlinkSync(deleteImage);
            return res.json({error:err})
        }
    },
    conclusionPrompt: async (req,res)=>{
        const imageUrl = `http://${req.headers.host}/${req.file.path.split("\\")[1]}`;
        const deleteImage = `${uploadFolder}\\${req.file.path.split("\\")[1]}`;
        try{
            const response = await axios.post('http://127.0.0.1:5000/conclusionPrompt',{data:{
                "imageUrl":`${imageUrl}`       }})
                await fs.unlinkSync(deleteImage);
                return res.json(response.data);
            }catch(err){
                await fs.unlinkSync(deleteImage);
            return res.json({error:err})
        }
    }
}

export default upload;