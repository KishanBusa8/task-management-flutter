import Joi from 'joi'

import {todoEnumCustomValidation}  from './customize.validation.js'

export const create = {
    body: Joi.object().keys({
        title: Joi.string().required(),
        description: Joi.string().required(),
        dueDate: Joi.string().optional(),
        status: Joi.string().required().custom(todoEnumCustomValidation),
    }),
}

export const update = {
    body: Joi.object().keys({
        title: Joi.string().optional(),
        description: Joi.string().optional(),
        dueDate: Joi.string().optional(),
        status: Joi.string().optional().custom(todoEnumCustomValidation),
    }),
}
