# Description:
#   hubot basic command.
#
# Commands:
#   hubot ping
#   hubot echo <*> - <$1>
#   hubot who am i - show your username

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

