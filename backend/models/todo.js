// todoModel.js

import mongoose from 'mongoose';
import {todoEnum} from '../utils/app-constans.js';

const { Schema } = mongoose;

const todoSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  status: {
    type: String,
    enum : todoEnum,
    default : 'todo',
    required: true,
  },
  dueTime : {
    type: String,
  },
  dueDate : {
    type: Date,
  },
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
},{ timestamps: true });

const Todo = mongoose.model('Todo', todoSchema);

export default Todo;
