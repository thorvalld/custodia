import db from "../db/mongo.ts";
import {RouterContext} from 'https://deno.land/x/oak/mod.ts';


const taskCollection = db.collection<TaskSchema>("task");
const quizCollection = db.collection<QuizSchema>("quiz");
const questionCollection = db.collection<QuestionSchema>("question");

interface QuizSchema{
    _id : {$oid : string},
    id : Number,
    reward : string,
    score : string,
    responses : string,
    status : string,
    parent_email : string,
    child_email : string,
    questions : (QuestionSchema)[] | null
}

interface QuestionSchema{
    _id : {$oid : string},
    id : Number,
    correctAnswer : string,
    answers : string,
    id_quiz : Number
}

interface TaskSchema{
    _id: { $oid: string },
    id : Number,
    lable : string,
    description : string,
    category : string,
    reward : number,
    status : number,
    created_at : Date,
    dueDate : Date,
    parent_email : string,
    child_email : string
    
}

//////////// TASKS /////////////

//get all parent tasks
const getTasks = async (context : RouterContext) => {
    const mail = await context.params.email;
    const tasks = await taskCollection.find({parent_email : mail}).toArray();
    context.response.body = tasks[0];
    context.response.status = 201;
}

//get all  tasks
const getAllTasks = async (context : RouterContext) => {
    const tasks = await taskCollection.find({ _id: { $ne: null } }).toArray();
    context.response.body = tasks;
    context.response.status = 201;
}

//sort by date
const sortByDate = async (context : RouterContext) => {
    const pid = await Number(context.params.id);
    const tasks  = await taskCollection.find({id_parent : pid}).sort({cearted_at: -1}).toArray();
    context.response.body = tasks[0];
    context.response.status = 201;
}

//get child tasks
const getChildTasks = async (context : RouterContext) => {
    const mail = await context.params.email;
    const tasks = await taskCollection.find({child_email : mail }).toArray();
    context.response.body = tasks;
    context.response.status = 201;
}

//get todo tasks

const getTodoTasks = async (context : RouterContext) => {
    const tasks = await taskCollection.find({status : "0%"}).toArray();
    context.response.body = tasks;
    context.response.status = 201;
}

//get doing tasks

const getDoingTasks = async (context : RouterContext) => {
    const tasks = await taskCollection.find({status : "50%"}).toArray();
    context.response.body = tasks;
    context.response.status = 201;
}

//get done tasks

const getDoneTasks = async (context : RouterContext) => {
    const tasks = await taskCollection.find({status : "100%"}).toArray();
    context.response.body = tasks;
    context.response.status = 201;
}

//add task
const addTask = async (context : RouterContext) => {
    const values = await context.request.body().value;
    const parent = await context.params.parent;
    const child = await context.params.child;
    const taskCount = await taskCollection.count({ lable : { $ne: null } });

    taskCollection.insertOne({
        "id" : taskCount+1,
        "lable" : values.lable,
        "description" : values.description,
        "category" : values.category,
        "reward" : values.reward,
        "status" : "0%",
        "created_at" : values.created_at,
        "dueDate" : values.dueDate,
        "parent_email" : parent,
        "child_email" : child,
        "colorVal" : values.colorVal
    });

    context.response.status = 201;
    context.response.body = "added succussfully";
}

const getTaskById = async (context : RouterContext)=>{
    const idTask = Number(context.params.id);
    const task = await taskCollection.find({id : idTask}).toArray();
    context.response.body = task[0];
}

// set task to in progress
const setTaskToOnprogress = async (context : RouterContext) => {

    const taskId = Number(context.params.id);

    const { matchedCount, modifiedCount, upsertedId } = await taskCollection.updateOne({id : taskId}, {$set : {status: "50%"}});
    context.response.body = matchedCount+" "+modifiedCount+" "+upsertedId;
    context.response.status  = 201;
}

//set task to completed
const setTaskToCompleted = async (context : RouterContext) => {

    const taskId = Number(context.params.id);

    const { matchedCount, modifiedCount, upsertedId } = await taskCollection.updateOne({id : taskId}, {$set : {status: "100%"}});
    context.response.body = matchedCount+" "+modifiedCount+" "+upsertedId;
    context.response.status  = 201;
}

//sort parent tasks by status

const sortParetTasksByStatus = async (context : RouterContext) => {
    const parentMail = context.params.mail;

    const tasks = await taskCollection.find({parent_email : parentMail}).sort({status : -1}).toArray();
    context.response.body = tasks;
    context.response.status = 201;

}

//sort parent tasks by status

const sortChildTasksByStatus = async (context : RouterContext) => {
    const parentMail = context.params.parent;
    const childMail = context.params.child;

    const tasks = await taskCollection.find({parent_email : parentMail, child_email : childMail}).sort({status : -1}).toArray();
    context.response.body = tasks;
    context.response.status = 201;

}

const deleteTask = async (context : RouterContext) => {
    const taskId = context.params.id;
    await taskCollection.deleteOne({ id : taskId});

    context.response.body = "deleted succufully !";

}

//////////// QUIZ /////////////

//add quiz
const addQuiz = async (context : RouterContext) => {

    const values = await context.request.body().value;
    const id = await context.params.id;
    const quizCount = await quizCollection.count({ _id : { $ne: null } });
    quizCollection.insertOne({
        id : quizCount+1,
        reward : values.reward,
        score : values.score,
        responses : values.responses,
        status : values.status,
        id_parent : values.id_parent,
        id_child : values.id_child,
        questions : values.questions
    });

    context.response.body = "quiz added";
    console.log("quiz added");
    context.response.status = 201;
}

//get all quizzes
/*const getAllQuizzes = async (context : RouterContext) => {
    const parentId = await context.params.id;
    const quizzes = quizCollection.find({ id_parent : 1 }).toArray();
    context.response.body = quizzes[0];
}*/

const getAllQuizzes = async (context : RouterContext) => {
    const id = await Number(context.params.id);
    const quiz  = await quizCollection.find({id_parent : id}).toArray();
    context.response.body = quiz[0];
    context.response.status = 201;
}


//////////// QUESTIONS /////////////



export {
    getAllQuizzes,
    getTasks,
    addTask,
    sortByDate,
    getTaskById,
    addQuiz,
    getChildTasks,
    setTaskToOnprogress,
    setTaskToCompleted,
    sortParetTasksByStatus,
    sortChildTasksByStatus,
    deleteTask,
    getTodoTasks,
    getDoingTasks,
    getDoneTasks,
    getAllTasks};