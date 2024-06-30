import httpStatus from 'http-status';
import Todo from '../models/todo.js';
import ApiError from '../utils/api-error.js';

const createTodo = async (req, res, next) => {
  try {
    const { title, description, status, dueDate,dueTime } = req.body;
    const todo = new Todo({
      title,
      description,
      status,
      dueDate,
      dueTime,
      user: req.user._id,
    });
    await todo.save();
    res.status(httpStatus.CREATED).json(todo);
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const getTodos = async (req, res, next) => {
  try {
    const todos = await Todo.find({ user: req.user._id });
    return res.status(httpStatus.OK).json(todos);
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const getTodoById = async (req, res, next) => {
  try {
    const todo = await Todo.find({ _id: req.params.id, user: req.user._id });
    if (!todo) {
      throw new ApiError(httpStatus.NOT_FOUND, 'Task not found!');
    }
    return res.status(httpStatus.OK).json(todo);
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const updateTodo = async (req, res, next) => {
  try {
    const { title, description, status, dueDate,dueTime } = req.body;
    const updatedTodo = await Todo.findByIdAndUpdate(
      req.params.id,
      {
        title,
        description,
        status,
        dueDate,
        dueTime,
      },
      { new: true }
    );
    if (!updatedTodo) {
      throw new ApiError(httpStatus.NOT_FOUND, 'Task not found!');
    }
    return res.status(httpStatus.OK).json(updatedTodo);
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const deleteTodo = async (req, res, next) => {
  try {
    const deletedTodo = await Todo.findByIdAndDelete(req.params.id);
    if (!deletedTodo) {
      throw new ApiError(httpStatus.NOT_FOUND, 'Task not found!');
    }
    return res.status(httpStatus.OK).json({ message: 'Task deleted successfully' });
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

export { createTodo, getTodos, getTodoById, updateTodo, deleteTodo };
