import { RouterContext } from "https://deno.land/x/oak/mod.ts"; 
import { SmtpClient } from "https://deno.land/x/smtp/mod.ts"; 
import db from "../db/mongo.ts";
import {v4} from "https://deno.land/std/uuid/mod.ts";


const client = new SmtpClient();

const connectionConfig = {
    hostname: 'smtp.gmail.com',
    port: 465,
    username: 'custodia.pim@gmail.com',
    password: 'Aze!1234'
};

await client.connectTLS(connectionConfig);


const SessionCollection = db.collection<SessionSchema>("pwSessions");

interface SessionSchema {
    email: string;
    validationCode: string;
    status: string;
}

const checkSession = async (ctx: RouterContext) => {


    const body =  ctx.request.body();
    const values = await body.value;
    const code = values.code;


    const  token = await SessionCollection.findOne({"validationCode": code });


    if (token) {
        if(token.status == "expired") {
            ctx.response.body = "session expired"
            ctx.response.status = 202 //fail code
        }
        else {
            ctx.response.body = "change password"
            ctx.response.status = 200 //ok code
        }
    } else {
        ctx.response.body = "code not valid"
        ctx.response.status = 308 //not found
    }
        
 
}

const generateCode = async (ctx: RouterContext) => {

    const body =  ctx.request.body();
    const values = await body.value;
    const email = values.email;

    const longCode = v4.generate();
    const  code = longCode.substr(32);

    const token = await SessionCollection.insertOne({"email": email,"validationCode": code,"status": "valid"});

    await client.send({
        from: "custodia.pim@gmail.com",
        to: email,
        subject: "Password reset Code",
        content: "Hello dear "+email+" , \n you can use the following code to reset your password :  \n "+code+" \n\n notice: it is usable only one time and available only for the next 24 hours"
    });

    ctx.response.status = 201;
}

const updateValidationCode = async (c: string) => {

    const user = await SessionCollection.updateOne({"validationCode": c},{
        $set: { "status": "expired" }  
    });
    
}



export {generateCode , checkSession, updateValidationCode}

