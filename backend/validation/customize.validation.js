import { todoEnum } from "../utils/app-constans.js"

export const objectId = (value, helpers) => {
    if (!value.match(/^[0-9a-fA-F]{24}$/)) {
        return helpers.message('"{{#label}}" must be a valid id format')
    }
    return value
}

export const password = (value, helpers) => {
    if (value.length < 6) {
        return helpers.message('password must be at least 6 characters')
    }
    if (!value.match(/\d/) || !value.match(/[a-zA-Z]/)) {
        return helpers.message('password must contain at least 1 letter and 1 number')
    }
    return value
}

export const todoEnumCustomValidation = (value, helpers) => {
    if (!todoEnum.includes(value)) {
        return helpers.message('Invalid Status')
    }
    
    return value
}

