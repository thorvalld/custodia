import { MongoClient } from "https://deno.land/x/mongo@v0.21.0/mod.ts";

//initialize mongo plugin

const client = new MongoClient();
await client.connect("mongodb://127.0.0.1:27017");

//const db = client.connect("mongodb+srv://amine:OOFPThHd7bVm4r1w@pim.br8fv.mongodb.net/myFirstDatabase?retryWrites=true&w=majority");

const db = client.database("pimmm");

export default db;