# Description:
#   execute when any bot respond regexp undefined.

util = require('util')

module.exports = (robot) ->

  cmds = []
  for help in robot.helpCommands()
    cmd = help.split(' ')[1]
    cmds.push(cmd) if cmds.indexOf(cmd) is -1
  util.log("cmds: " + cmds)

  robot.respond /(.+)$/i, (msg) ->
    cmd = msg.match[1].split(' ')[0]
    unless cmds.indexOf(cmd) is -1
      return

    msg.reply "Command: #{cmd} not found. Supported commands are '@globot help'"
    return
