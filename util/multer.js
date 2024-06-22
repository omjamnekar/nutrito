import multer from "multer";
import path from "path";

const uploadImage = multer({
    storage:multer.diskStorage({
        destination:(req,file,cb)=>{
            return cb(null,"uploads");
        },
        filename:(req,file,cb)=>{
            return cb(null,file.originalname.split(".")[0]+"-"+Date.now()+path.extname(file.originalname))
        }
    })
})

export default uploadImage;