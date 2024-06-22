import fs from "fs";
import { GoogleGenerativeAI } from "@google/generative-ai";
import {initialPrompt,ratioPrompt,healthPrompt,conclusionPrompt} from "../util/prompts.js";
import dotenv from "dotenv";
dotenv.config();

const genAI = new GoogleGenerativeAI(process.env.API_KEY);


const generateData = async (imagePath,mimetype) => {
    const fileToGenerativePart = (path, mimeType) => {
        return {
          inlineData: {
            data: Buffer.from(fs.readFileSync(path)).toString("base64"),
            mimeType
          },
        };
      }
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash"});
    
    const imageParts = [
        fileToGenerativePart(imagePath, mimetype)
    ];
    const initialPromptResult = await model.generateContent([initialPrompt, ...imageParts]);
    const ratioPromptResult = await model.generateContent([ratioPrompt, ...imageParts]);
    const healthPromptResult = await model.generateContent([healthPrompt, ...imageParts]);
    const conclusionPromptResult = await model.generateContent([conclusionPrompt, ...imageParts]);
    
    const  initialPromptJson = JSON.parse(initialPromptResult.response.text());
    const  ratioPromptJson = JSON.parse(ratioPromptResult.response.text());
    const  healthPromptJson = JSON.parse(healthPromptResult.response.text());
    const  conclusionPromptJson = JSON.parse(conclusionPromptResult.response.text());
    
     return {initialPrompt:initialPromptJson,ratioPrompt:ratioPromptJson,healthPrompt:healthPromptJson,conclusionPrompt:conclusionPromptJson};
}

export default generateData;