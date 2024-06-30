import express from 'express';
import {getAllUser, login, getUserById, createUser, updateUser, deleteUser} from '../controllers/userController.js';

const userRouter = express.Router();

userRouter.get('/', getAllUser);
userRouter.post('/login', login);
userRouter.get('/:id', getUserById);
userRouter.post('/register', createUser);
userRouter.put('/:id', updateUser);
userRouter.delete('/:id', deleteUser);

export default userRouter;