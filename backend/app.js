import { config } from 'dotenv';
import express from 'express';
import passport from 'passport';
import connectDB from './config/db.js';
import router from './routes/userRoutes.js';
import initializePassport from './config/passport.js';
import authenticate from './middleware/auth.js';
import todoRouter from './routes/todoRouter.js';

config();
const app = express();

connectDB();

initializePassport(passport);

app.use(express.json());

app.use('/api/users', router);

app.use('/api/todos', authenticate, todoRouter);


app.listen(8000, () => console.log('Server is running on port 8000'));
