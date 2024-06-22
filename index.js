import express from "express";
import path from "path";
import fs from "fs";
import uploadImage from "./util/multer.js";
import upload from "./routes/upload.js";

const port = 4000;

const _dirname = path.resolve();
const uploadFolder = path.join(_dirname,"uploads");
fs.mkdirSync(uploadFolder,{recursive:true})

const app = express();
app.use(express.static(uploadFolder))

app.get("/",(req,res)=>{
    res.json({hostname:req.headers.host,route:req.url}    )
})


app.get("/api",(req,res)=>{
    console.log(uploadFolder)
    let pictures = fs.readdirSync(uploadFolder);
    let picturesPath = [];
    for(let picture of pictures) picturesPath.push(req.headers.host+"/"+picture)
    res.status(200).json({picturesPath});
})


app.post("/api/upload",uploadImage.single("picture"),upload)

app.listen(port,()=>{
    console.log(`Server is started at port ${port}`)
})