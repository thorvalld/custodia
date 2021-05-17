import { RouterContext } from "https://deno.land/x/oak/mod.ts"; 
import db from "../db/mongo.ts";


const chatCollection = db.collection<MessageSchema>("chat");

interface MessageSchema {
    from: string;
    to: string;
    content: string;
}

const addMsg = async (m: MessageSchema) => {


    const chat = await chatCollection.insertOne({"from": m.from,"to": m.to,"content": m.content});
    
}

const addMsggg = async (ctx: RouterContext) => {


    const body =  ctx.request.body();
    const values = await body.value;
    const from = values.from;
    const to = values.to;
    const content = values.content;

    const chat = await chatCollection.insertOne({"from": from,"to": to,"content": content});


    
    ctx.response.body = chat;
    
}



const getConversation = async (ctx: RouterContext) => {


    const body =  ctx.request.body();
    const values = await body.value;
    const from = values.from;
    const to = values.to;



    const  chat = await chatCollection.find({
        $or: [ { 
            $and: [
            {"from": from },
            {"to": to }
             ]  }, {
            $and: [
            {"from": to },
            {"to": from }
           ] } ]
     }).toArray();
    
        ctx.response.body = JSON.stringify(chat);
 
}






export {addMsg, getConversation, addMsggg};