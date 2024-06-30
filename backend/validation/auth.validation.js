import Joi from 'joi'

import {password}  from './customize.validation.js'

export const loginSchema = {
    body: Joi.object().keys({
        email: Joi.string().required(),
        password: Joi.string().required(),
    }),
}

export const registerSchema = {
    body: Joi.object().keys({
        name: Joi.string().required(),
        email: Joi.string().required().email(),
        password: Joi.string().required().custom(password),
    }),
}

export const resetPasswordSchema = {
    body: Joi.object().keys({
        id: Joi.string().required(),
        password: Joi.string().required().custom(password),
    }),
}

