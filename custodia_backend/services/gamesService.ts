import { RouterContext } from "https://deno.land/x/oak/mod.ts"; 
import db from "../db/mongo.ts";


const gameCollection = db.collection<RoomSchema>("rooms");

interface RoomSchema {
    roomId: string;
    status: string;
}

const checkroom = async (ctx: RouterContext) => {


    const body =  ctx.request.body();
    const values = await body.value;
    const roomId = values.roomId;


    const  room = await gameCollection.findOne({"roomId": roomId })


    if (room) {
        if(room.status == "full") {
            ctx.response.body = "room is full"
        }
        else {
            ctx.response.body = "joining"
        }
    } else {
        ctx.response.body = "room doesn't exist"
    }
        
 
}

const addRoom = async (r: RoomSchema) => {


    const chat = await gameCollection.insertOne({"roomId": r.roomId,"status": r.status});
    
}

const updateRoom = async (roomId: string) => {

    const user = await gameCollection.updateOne({"roomId": roomId},{
        $set: { "status": "full" }  
    });

}




export {checkroom, addRoom, updateRoom}