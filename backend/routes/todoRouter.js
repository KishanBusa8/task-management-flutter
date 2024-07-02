import express from 'express';
import {
  createTodo,
  getTodos,
  getTodoById,
  updateTodo,
  deleteTodo,
  deleteAllTodos,
} from '../controllers/todoController.js';
import validate from '../middleware/validate.js';
import { create, update } from '../validation/todo.validation.js';
const router = express.Router();

router.post('/',validate(create), createTodo); // Create a new todo item
router.get('/', getTodos); // Get all todo items for the authenticated user
router.get('/:id', getTodoById); // Get a todo item by its ID
router.put('/:id',validate(update), updateTodo); // Update a todo item by its ID
router.delete('/:id', deleteTodo);  // delete todo by id
router.delete('/', deleteAllTodos);  // delete all tasks

export default router;
