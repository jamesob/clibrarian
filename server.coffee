#
# CLIbrarian 
#
# keep track of the commands you execute most on the cli 
#
# inspired by
# matt.might.net/articles/console-hacks-exploiting-frequency/
#

express  = require('express')
mongoose = require 'mongoose'
app      = express.createServer()
Schema   = mongoose.Schema

app.use express.bodyParser()
db = mongoose.connect('mongodb://localhost/clibrarian')


makeCommandSchema = ->
    new Schema
        command: String
        count: Number

Command = mongoose.model('Command', makeCommandSchema())


upsertCommand = (cmd) ->
    opts = upsert: true
    cond = command: cmd
    count = $inc: { count: 1 }

    back = (err, num) ->
        console.log "Updated '#{cmd}'."
    
    Command.update(cond, count, opts, back)


app.post '/command', (req, res) ->
    cmd = req.body.command

    upsertCommand(cmd)
    replyCallback = (err, doc) ->
        res.json
            command: doc.command
            numSeen: doc.count

    Command.findOne({ command: cmd }, replyCallback)


app.listen 3000
console.log("Express server listening on port"
            " #{app.address().port} in #{app.settings.env} mode")
