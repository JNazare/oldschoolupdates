mongoose = require('mongoose')
findOrCreate = require('mongoose-findorcreate')

userSchema = new (mongoose.Schema)(
    fbId: String
    )

userSchema.plugin(findOrCreate)
mongoose.model 'User', userSchema

uristring = process.env.MONGOLAB_URI or process.env.MONGOHQ_URL or 'mongodb://localhost/oldschooldb'

mongoose.connect uristring, (err, res) ->
    if err
        console.log 'ERROR connecting to: ' + uristring + '. ' + err
    else
        console.log 'Succeeded connected to: ' + uristring
    return