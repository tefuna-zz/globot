# Description:
#   hubot basic command.
#
# Commands:
#   bot ping - reply 'PONG!'
#   bot echo <*> - show <$1>
#   bot who - show your username
#   bot help - show supported command list

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send "PONG!"
    return

  robot.respond /ECHO (.*)$/i, (msg) ->
    msg.send msg.match[1]
    return 

  robot.respond /who/i, (msg) ->
    msg.send "You are #{msg.message.user.name}"
    return

  robot.respond /help$/i, (msg) ->
    cmds = ""
    for cmd in robot.helpCommands()
      cmds = cmds + cmd + "\n"
    msg.send "globot support command..."
    msg.send cmds
    return
