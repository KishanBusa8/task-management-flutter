import { ExtractJwt, Strategy } from 'passport-jwt';
import User from '../models/user.js';

const initializePassport = async (passport) => {
  const jwtOptions = {
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: process.env.JWT_SECRET_KEY,
  };

  const jwtStrategy = new Strategy(jwtOptions, async function (jwt_payload, next) {
    const savedUser = await User.findById(jwt_payload._id);
    if (savedUser) {
      return next(null, savedUser);
    }
    return next(null, false);
  });
  passport.use('jwt', jwtStrategy);
};

export default initializePassport;
