import express from 'express';
import bodyParser from "body-parser";
import connectDB from './config/db.js';
import cors from 'cors';
import 'dotenv/config';

// Controller import
import categoryRouter from "./routes/categoryRoute.js";



connectDB();

const app = express();
const PORT = process.env.PORT;

app.use(bodyParser.json());
app.use(cors());

// API endpoints
app.use('/categories', categoryRouter);


// Global Error Handler
app.use((error, req, res, next) => {
    res.status(500).json({ success: false, message: error.message, data: null });
});

app.listen(PORT, () => {
    console.log(`Connected to Port ${PORT}`);
})