const express = require('express');
const morgan = require('morgan');
const path = require('path');
const exphbs = require('express-handlebars');
const session = require('express-session');
const expressValidator  = require('express-validator');
const passport = require('passport');
const flash = require('connect-flash');
const MySQLStore = require('express-mysql-session')(session);
const bodyParser = require('body-parser');

const { database } = require('./keys');

//Inicializaciones
const app = express();
require('./lib/passport');

//Settings
app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
  defaultLayout: 'main',
  layoutsDir: path.join(app.get('views'), 'layouts'),
  partialsDir: path.join(app.get('views'), 'partials'),
  extname: '.hbs',
  helpers: require('./lib/handlebars')
}))
app.set('view engine', '.hbs');

//Middlewares
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(session({
  secret: 'faztmysqlnodemysql',
  resave: false,
  saveUninitialized: false,
  store: new MySQLStore(database)
}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());
app.use(expressValidator());

//global variables
app.use((req, res, next) => {
    app.locals.success = req.flash('success');
    app.locals.message = req.flash('message');
    app.locals.user = req.user;
    next();
  });

//Routes
app.use(require('./routes/index'));
app.use(require('./routes/authentication'));
app.use('/tarjetas', require('./routes/tarjetas'));
app.use('/chofer', require('./routes/chofer'));
app.use('/bus', require('./routes/bus'));
app.use('/transaccion', require('./routes/transaccion'));
app.use('/reportes', require('./routes/reportes'));
app.use('/comparativas', require('./routes/comparativas'));

// Public
app.use(express.static(path.join(__dirname, 'public')));


// Starting
app.listen(app.get('port'), () => {
  console.log('Server is in port', app.get('port'));
});
