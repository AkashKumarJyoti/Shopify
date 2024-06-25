import mongoose from 'mongoose';

const connectDB = () => {
    const url = process.env.DB_STRING;
    mongoose.connect(url)
        .then(() => {
            console.log("MongoDB connected");
        })
        .catch((error) => {
            console.error("MongoDB connection error:", error);
        });
}

export default connectDB;