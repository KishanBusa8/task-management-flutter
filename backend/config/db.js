import mongoose from 'mongoose';

async function connectDB() {
  try {
    mongoose.connect(process.env.MONGO_URL);
    console.log('Connected to database');
  } catch (error) {
    console.log(error);
  }
}

export default connectDB;
