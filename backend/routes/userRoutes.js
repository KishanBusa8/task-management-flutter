import express from 'express';
import { registerUser, loginUser, resetPassword, getUser } from '../controllers/userController.js';
import validate from "../middleware/validate.js";
import { loginSchema, registerSchema,resetPasswordSchema } from "../validation/auth.validation.js";
import authenticate from '../middleware/auth.js';

const router = express.Router();

router.post('/register',validate(registerSchema) , registerUser);

router.post('/login',validate(loginSchema) ,loginUser);
router.get('/get-profile',authenticate ,getUser);

router.post('/reset-password',validate(resetPasswordSchema), resetPassword);

export default router;
