import Joi from  'joi'
import httpStatus from 'http-status'
import ApiError from '../utils/api-error.js'
import pickKeys from '../utils/pick-keys.js'

export default (schema) => (req, res, next) => {
    const validSchema = pickKeys(schema, ['params', 'query', 'body'])
    const object = pickKeys(req, Object.keys(validSchema))
    const { value, error } = Joi.compile(validSchema)
        .prefs({ errors: { label: 'key' }, abortEarly: false })
        .validate(object)

    if (error) {
        const errorMessage = error.details.map((details) => details.message).join(', ')
        return res.status(httpStatus.BAD_REQUEST).send(new ApiError(httpStatus.BAD_REQUEST, errorMessage))
    }
    Object.assign(req, value)
    return next()
}
