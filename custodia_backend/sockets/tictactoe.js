import {v4} from "https://deno.land/std/uuid/mod.ts";
import {updateRoom, addRoom} from '../services/gamesService.ts';



/**
 * GameRoom: {
 *      roomId: string,
 *      fen: string,
 *      turn: string,
 *      player1: user,
 *      player2: user
 * }
 */

var roomsList = [];


export default async function tictactoe(ws){
     console.log('connected');

    for await (const data of ws) {
        console.log(data);
        

        const event = typeof data === 'string' ? JSON.parse(data) : data;
        switch (event.event) {
            case 'create': {
                const userObj = {
                    ws
                };
                const roomLongiId = v4.generate();
                const  roomId = roomLongiId.substr(30);

                console.log(roomId);

                const room = {
                    "roomId": roomId,
                    "status": "available"
                }    

                addRoom(room);

                const gameRoomObj = {
                    roomId: roomId,
                    turn: "O",
                    index: 0,
                    player1: userObj,
                    player2: null,
                }

                roomsList.push(gameRoomObj);

                ws.send('{"roomId":"'+roomId+'","index":'+0+',"turn":"'+gameRoomObj.turn+'","event":"welcome"}');
                break;
            }

            case 'join': {
                const userObj = {
                    ws
                };

                const rooms = roomsList;
                for (const room of rooms){
                    if(room.roomId==event.roomId){
                        room.player2 = userObj;
                        updateRoom(room.roomId);
                    }
                }
                console.log(event)
                break;
            }


            case 'move': {

                const rooms = roomsList;
                for (const room of rooms){
                    if(room.roomId==event.roomId){

                        if(room.player2 != null) {
                            room.index = event.index;
                            room.turn = event.turn;
                            room.player1.ws.send('{"roomId":"'+room.roomId+'","index":'+room.index+',"turn":"'+room.turn+'","event":"move"}');
                            room.player2.ws.send('{"roomId":"'+room.roomId+'","index":'+room.index+',"turn":"'+room.turn+'","event":"move"}');
                                 
                        }

                    }
                }


                break;
            }
        

        }
        
    }

}