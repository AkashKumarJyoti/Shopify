import express from 'express';
import bodyParser from "body-parser";
import connectDB from './config/db.js';
import 'dotenv/config';

connectDB();

const app = express();
const PORT = process.env.PORT;

app.use(bodyParser.json());

app.listen(PORT, () => {
    console.log(`Connected to Port ${PORT}`);
})