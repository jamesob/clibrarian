#
# CLIbrarian 
#
# keep track of the commands you execute most on the cli 
#
# inspired by
# matt.might.net/articles/console-hacks-exploiting-frequency/
#

express  = require 'express'
mongoose = require 'mongoose'
app      = express.createServer()
 
CMD_ENDPOINT = '/command'
pr = console.log
db = mongoose.connect 'mongodb://localhost/clibrarian'
app.use express.bodyParser()


makeCommandSchema = ->
    new mongoose.Schema
        command: String
        count: Number

Command = mongoose.model 'Command', makeCommandSchema()


upsertCommand = (cmd) ->
    opts = upsert: true
    cond = command: cmd
    count = $inc: { count: 1 }

    back = (err, num) ->
        pr "Updated '#{cmd}'."
    
    Command.update cond, count, opts, back


app.get CMD_ENDPOINT, (req, res) ->
    Command.find {}, (err, docs) ->
        res.json docs


app.post CMD_ENDPOINT, (req, res) ->
    cmd = req.body.command

    upsertCommand(cmd)
    replyCallback = (err, doc) ->
        res.json doc

    Command.findOne({ command: cmd }, replyCallback)


app.listen 3000
port = app.address().port
env = app.settings.env

pr "Express server listening on port #{port} in #{env} mode"
