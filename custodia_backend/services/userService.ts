import { RouterContext } from "https://deno.land/x/oak/mod.ts"; 
import { AES }  from "https://deno.land/x/god_crypto/aes.ts";
import db from "../db/mongo.ts";
import {updateValidationCode} from "../services/updatePassService.ts";


const usersCollection = db.collection<UserSchema>("users");



// hashing setup
const aes = new AES("Hello World AES!", {
    mode: "cbc",
    iv: "random 16byte iv",
  });


// interface user
interface UserSchema{
    _id: string;
    fullname: string;
    parentEmail: string;
    email: string;
    password: string;
    phoneNumber: string;
    macAddress?: string;
    role: string;
    birthDate: string;
    avatarURL?: string;
    credits?: number;
}

//reset password

const resetPassword = async (ctx: RouterContext) => {


    const body =  ctx.request.body();
    const values = await body.value;


    const encryptedPW = await aes.encrypt(values.password);

    const user = await usersCollection.updateOne({"email": values.email},{
        $set: { "password": encryptedPW.hex() }  
    });


    ctx.response.body = "password changed successfully"

    updateValidationCode(values.code)
}


//get ALL users
const getUsers = async (ctx: RouterContext) => {

    const users = await usersCollection.find();
    ctx.response.body=users;

}

// Registration
const register = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;

    const encryptedPW = await aes.encrypt(values.password);

    const countEmail = await usersCollection.count({"email": values.email});
    const countPhone = await usersCollection.count({"phone": values.phone});

    if(countEmail>0){
        ctx.response.body = "this email is already in use";
        ctx.response.status = 202
    } else if (countPhone>0){
        ctx.response.body = "this phone number is already in use";
        ctx.response.status = 203
    } else {
        const id = await usersCollection.insertOne({
            "email": values.email,
            "password": encryptedPW.hex(),
            "fullname": values.fullname,
            "phone": values.phone,
            "role": "PARENT",
            "birthDate": values.birthDate
        });
        
        ctx.response.status = 201;
        ctx.response.body = "user created"
    }

}

// LOGIN
const login = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;
    const encryptedPW = await aes.encrypt(values.password);
    const encryptedMac = await aes.encrypt(values.macAddress);
    
    const user =  await usersCollection.findOne({"email": values.email});

    if(!user){
        ctx.response.body="user not found"
        ctx.response.status = 404 ;
    } else { 
        if(user.password !== undefined){

            const x: string = user.password;

            if(x==encryptedPW.hex()){
                


                if(!user!.macAddress){
                    ctx.response.body = "login successful without mac"
               } else if (user.macAddress==encryptedMac.hex()){
                   console.log(user!.macAddress);
                   ctx.response.body = "login successful with mac"
                   ctx.response.status = 200
               } else {
                    ctx.response.body = "connection from new device"
                    ctx.response.status = 200
               }

            } else {
                ctx.response.body = "wrong credentials"
                ctx.response.status = 300
            }
            
        } else {
            ctx.response.body = "error no pw"
            ctx.response.status = 302
        }
    }

}

// DELETE USER
const deleteUser = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;
    const email = values.email;

    const user = await usersCollection.deleteOne({"email": email});

    ctx.response.body="user deleted"
    
}

//ADD CHILD

const addChild = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;

    
    const encryptedPW = await aes.encrypt(values.password);

    const countEmail = await usersCollection.count({"email": values.email});
    const countPhone = await usersCollection.count({"phone": values.phone});

    if (countPhone>0){
        ctx.response.body = "this phone number is already in use";
        ctx.response.status = 203
    } else {
        const id = await usersCollection.insertOne({
            "emailParent": values.emailParent,
            "email": "",//values.email,
            "password": "", //encryptedPW.hex(),
            "fullname": values.fullname,
            "phone": values.phone,
            "role": "CHILD",
            "birthDate": values.birthDate,//values.birthDate,
            "credits": 0
        });
        
        ctx.response.status = 201;
        ctx.response.body = "child added"
    }
    
}

//GET CHILDREN BY EMAIL
const getChildren = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;
    const email = values.email;

    const user = await usersCollection.find({"emailParent": email}).toArray();

    if(user!==undefined) {

        ctx.response.body = JSON.stringify(user);
        
    }
    
}

//ADD MAC SECURITY
const addMac = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;
    const email = values.email;
    

    const encryptedMac = await aes.encrypt(values.macAddress);

    const user = await usersCollection.updateOne({"email": email},{
        $set: { "macAddress": encryptedMac.hex() }  
    });
    ctx.response.body=user;
}


//get current user
const getUser = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;
    const email = values.email;
    

    const user = await usersCollection.findOne({"email": email});
    
    ctx.response.body=user;
}



export {getUsers, register, login, deleteUser, addChild, getChildren, addMac, getUser, resetPassword};