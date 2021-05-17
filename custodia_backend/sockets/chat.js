import {addMsg} from "../services/chatService.ts";
import {v4} from "https://deno.land/std/uuid/mod.ts";


/**
 * user: {
 *    email: string,
 *    ws: WebSocket
 * }
 */
var usersList = [];


export default async function chat(ws){
     console.log('connected');
   //  const userId = v4.generate();

    for await (const data of ws) {
        console.log(data);
        

        const event = typeof data === 'string' ? JSON.parse(data) : data;
        switch (event.event) {
            case 'join': {
                const userObj = {
                    email: event.from,
                    ws
                };

                usersList.push(userObj);

                break;
            }
            case 'message': {

                const msg = {
                    "to": event.to,
                    "from": event.from,
                    "content": event.content
                }    
                addMsg(msg);

                ws.send(data);
                const users = usersList;
                for (const user of users){
                    if(user.email==event.to){
                        user.ws.send(data);
                    }
                }
                break;
            }
        
        case 'close': {
            const userObj = {
                email: event.from,
                ws
            };

            usersList.pop(userObj);
        }

        }
        
    }

}