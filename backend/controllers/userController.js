import User from '../models/user.js';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import ApiError from '../utils/api-error.js';
import httpStatus from 'http-status';

const registerUser = async (req, res, next) => {
  try {
    const { name, email, password } = req.body;
    const alreadyUser = await User.findOne({ email: req.body.email });
    if (alreadyUser) {
      throw new ApiError(500, 'User already exist!');
    }
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = new User({ name, password: hashedPassword, email });
    await user.save();
    const token = jwt.sign({ id: user._id.toString() }, process.env.JWT_SECRET_KEY);
    res.status(httpStatus.CREATED).send({ user, token });
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const loginUser = async (req, res, next) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    if (!user) {
      throw new ApiError(httpStatus.NOT_FOUND, 'User not found!');
    }
    const isMatch = await bcrypt.compare(req.body.password, user.password);
    if (!isMatch) {
      throw new ApiError(httpStatus.NOT_FOUND, 'Password does not match!');
    }
    const token = jwt.sign({ _id: user._id.toString() }, process.env.JWT_SECRET_KEY);
    res.status(httpStatus.OK).send({ user, token });
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const getUser = async (req, res, next) => {
  try {
    const user = await User.findById(req.user._id );
    if (!user) {
      throw new ApiError(httpStatus.NOT_FOUND, 'User not found!');
    }
  res.status(httpStatus.OK).send({ user });
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });
  }
};

const resetPassword = async (req, res, next) => {
  try {
    const hashedPassword = await bcrypt.hash(req.body.password, 10);
    const user = await User.findByIdAndUpdate(req.body.id,
      { password: hashedPassword },
      { new: true }
    );
    if (!user) {
      throw new ApiError(httpStatus.NOT_FOUND, 'User not found!');
    }

    res.status(httpStatus.OK).send({ user });
  } catch (error) {
    res.status(error.statusCode ?? httpStatus.BAD_REQUEST).send({
      error: error.message ?? error
    });  }
};

export { registerUser, loginUser, resetPassword, getUser };
