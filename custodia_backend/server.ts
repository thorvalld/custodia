import { Application, Router } from "https://deno.land/x/oak/mod.ts"; 
import {getUsers, register, login, deleteUser, addChild, getChildren, addMac, getUser, resetPassword} from "./services/userService.ts";
import {addMsggg,getConversation} from "./services/chatService.ts";
import {checkSession,generateCode} from "./services/updatePassService.ts";
import { listenAndServe} from "https://deno.land/std/http/server.ts";
import { acceptWebSocket, acceptable} from "https://deno.land/std/ws/mod.ts";
import {checkroom} from "./services/gamesService.ts";
import chat from './sockets/chat.js';
import chess from './sockets/chess.js';
import tictactoe from './sockets/tictactoe.js';

import {getAllQuizzes, getTasks,getAllTasks, addTask,getTodoTasks,getDoingTasks,getDoneTasks, sortByDate, getTaskById, addQuiz, getChildTasks, setTaskToOnprogress, setTaskToCompleted, sortParetTasksByStatus, sortChildTasksByStatus,
    deleteTask} from "./services/taskService.ts";


//Back-end router *************************

const router = new Router();

router
    .get('/users', getUsers)
    .post('/user', register)
    .post('/login', login)
    .delete('/user', deleteUser)
    .post('/child' , addChild)
    .get('/children', getChildren)
    .put('/mac' , addMac)
    .post('/addmsg' , addMsggg)
    .post('/msgs' , getConversation)
    .post('/getUser', getUser)
    .post('/generateCode', generateCode)
    .post('/checkSession', checkSession)
    .post('/resetPassword', resetPassword)
    .post('/checkroom', checkroom)
    //phase2
    .get("/getTasksByParentMail/:email", getTasks)
    .get("/getTasksByChildMail/:email", getChildTasks)
    .get("/getTaskById/:id", getTaskById)
    .get("/getTodoTasks", getTodoTasks)
    .get("/getDoingTasks", getDoingTasks)
    .get("/getDoneTasks", getDoneTasks)
    .get("/getAllTasks", getAllTasks)
    .post("/addTask/:parent/:child", addTask)
    .put("/setTaskToOnprogress/:id", setTaskToOnprogress)
    .put("/setTaskToCompleted/:id", setTaskToCompleted)
    .get("/sortParetTasksByStatus/:mail", sortParetTasksByStatus)
    .get("/sortChildTasksByStatus/:parent/:child", sortChildTasksByStatus)
    .get("/getAllQuizzes/:parentId", getAllQuizzes)
    .post("/addQuiz/:id", addQuiz)
    .delete("/deleteTask/:id", deleteTask);


const app = new Application();

app.use(router.routes());
app.use(router.allowedMethods());

app.listen({port: 8000});
console.log("server up and running");


// SOCKET CHAT *******************************

listenAndServe({port: 4000}, async (req) => {
    if(acceptable(req)) {

    await    acceptWebSocket({
            conn: req.conn,
            bufReader: req.r,
            bufWriter: req.w,
            headers: req.headers,
        }).then(chat);
    }
});


// SOCKET CHESS **************************


listenAndServe({port: 5000}, async (req) => {
    if(acceptable(req)) {

    await    acceptWebSocket({
            conn: req.conn,
            bufReader: req.r,
            bufWriter: req.w,
            headers: req.headers,
        }).then(chess);
    }
});

//SOCKET TICTACTOE **********************

listenAndServe({port: 6000}, async (req) => {
    if(acceptable(req)) {

    await    acceptWebSocket({
            conn: req.conn,
            bufReader: req.r,
            bufWriter: req.w,
            headers: req.headers,
        }).then(tictactoe);
    }
});




console.log("server started");