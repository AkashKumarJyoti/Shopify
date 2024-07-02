import express from 'express';
import bodyParser from "body-parser";
import connectDB from './config/db.js';
import cors from 'cors';
import 'dotenv/config';

// Router import
import categoryRouter from "./routes/categoryRoute.js";
import subCategoryRouter from './routes/subCategoryRoute.js';
import brandRouter from './routes/brandRoute.js';
import variantTypeRouter from './routes/variantTypeRoute.js';
import variantRouter from './routes/variantRoute.js';
import userRouter from './routes/userRoute.js';
import productRouter from './routes/productRoute.js';
import couponRouter from './routes/couponCodeRoute.js';
import posterRouter from './routes/posterRoute.js';

connectDB();

const app = express();
const PORT = process.env.PORT;

app.use(bodyParser.json());
app.use(cors());

// API endpoints for image
app.use('/image/products', express.static('public/products'));
app.use('/image/category', express.static('public/category'));
app.use('/image/poster', express.static('public/posters'));

// API endpoints
app.use('/categories', categoryRouter);
app.use('/subCategories', subCategoryRouter);
app.use('/brands', brandRouter);
app.use('/variantTypes', variantTypeRouter);
app.use('/variants', variantRouter);
app.use('/users', userRouter);
app.use('/products', productRouter);
app.use('/couponCodes', couponRouter);
app.use('/posters', posterRouter);

// Global Error Handler
app.use((error, req, res, next) => {
    res.status(500).json({ success: false, message: error.message, data: null });
});

app.listen(PORT, () => {
    console.log(`Connected to Port ${PORT}`);
})