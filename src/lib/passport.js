const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('./helpers');

passport.use('local.signin', new LocalStrategy({
  usernameField: 'nombreusuario',
  passwordField: 'password',
  passReqToCallback: true
}, async (req, nombreusuario, password, done) => {
  const rows = await pool.query('SELECT * FROM usuarios WHERE nombreusuario = ?', [nombreusuario]);
  if (rows.length > 0) {
    const user = rows[0];
    const validPassword = await helpers.matchPassword(password, user.password)
    if (validPassword) {
      done(null, user, req.flash('success', 'Welcome ' + user.nombreusuario));
    } else {
      done(null, false, req.flash('message', 'Incorrect Password'));
    }
  } else {
    return done(null, false, req.flash('message', 'The nombreusuario does not exists.'));
  }
}));

passport.use('local.signup', new LocalStrategy({
  usernameField: 'nombreusuario',
  passwordField: 'password',
  passReqToCallback: true
}, async (req, nombreusuario, password, done) => {

  const { nombrecompleto } = req.body;
  let newUser = {
    nombrecompleto,
    nombreusuario,
    password
  };
  newUser.password = await helpers.encryptPassword(password);
  // Saving in the Database
  const result = await pool.query('INSERT INTO usuarios SET ? ', newUser);
  newUser.id = result.insertId;
  return done(null, newUser);
}));

passport.serializeUser((user, done) => {
  done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
  const rows = await pool.query('SELECT * FROM usuarios WHERE id = ?', [id]);
  done(null, rows[0]);
});

