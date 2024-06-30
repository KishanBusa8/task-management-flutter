const customErrorNames = {
  RESOURCE_NOT_FOUND: 'RESOURCE_NOT_FOUND',
  UNAUTHORIZED: 'UNAUTHORIZED',
  BAD_REQUEST: 'BAD_REQUEST',
  FORBIDDEN: 'FORBIDDEN',
};
Object.freeze(customErrorNames);

const globalErrorHandler = (err, req, res, next) => {
  let status;
  switch (err) {
    case customErrorNames.RESOURCE_NOT_FOUND:
      status = 404;
      break;
    case customErrorNames.UNAUTHORIZED:
      status = 401;
      break;
    case customErrorNames.BAD_REQUEST:
      status = 400;
      break;
    case customErrorNames.FORBIDDEN:
      status = 403;
      break;
    default:
      status = 500;
  }
  req.log.error(err);
  res.status(status).json({ errors: [{ message: err.message }] });
  next();
};

export default  globalErrorHandler ;
