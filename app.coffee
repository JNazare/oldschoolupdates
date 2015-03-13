express = require('express')
path = require('path')
favicon = require('static-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')
mongoose = require('mongoose')
session = require('express-session')

passport = require('passport')
FacebookStrategy = require('passport-facebook').Strategy
db = require('./models/db')
User = mongoose.model('User')

routes = require('./routes/index')
users = require('./routes/users')
auth = require('./routes/auth')
app = express()

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'jade'
app.use favicon()
app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()

# add session functionality
app.use session(
    resave: false
    saveUninitialized: false
    secret: 'keyboard cat')

app.use express.static(path.join(__dirname, 'public'))

app.use(passport.initialize())
app.use(passport.session())

passport.use new FacebookStrategy({
  clientID: process.env.OLDSCHOOLUPDATES_FBID
  clientSecret: process.env.OLDSCHOOLUPDATES_FBSECRET
  callbackURL: 'http://localhost:3000/auth/facebook/callback'
}, (accessToken, refreshToken, profile, done) ->
  console.log profile.id
  User.findOrCreate {"fbId": profile.id}, (err, user) ->
    if err
      console.log err
      return done(err)
    console.log user
    done null, user
    return
  return
)

passport.serializeUser (user, done) ->
  done null, user
  return
passport.deserializeUser (user, done) ->
  done null, user
  return


app.use '/', routes
app.use '/users', users
app.use '/auth', auth

#/ catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next err
  return

#/ error handlers
# development error handler
# will print stacktrace
if app.get('env') == 'development'
  app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
      message: err.message
      error: err
    return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
  res.status err.status or 500
  res.render 'error',
    message: err.message
    error: {}
  return
module.exports = app
