# Description
#   handle undefined bot command.
#
# Dependencies:
#   "globy-common": "latest"
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Notes:
#   defined commands are determined by each scripts "Commands" description.
#
# Author:
#   globy

# =============================================================================
# imports.
# =============================================================================
gc = require 'globy-common'

# =============================================================================
# robot main.
# =============================================================================
module.exports = (robot) ->

  # logging supported command at startup
  cmds = []
  for help in robot.helpCommands()
    cmd = help.split(' ')[1]
    cmds.push(cmd) if cmds.indexOf(cmd) is -1
  gc.logInfo "supported commands: #{cmds}"

  #
  # handle undefined command.
  #
  robot.respond /(.+)$/i, (msg) ->
    cmd = msg.match[1].split(' ')[0]
    unless cmds.indexOf(cmd) is -1
      return
    gc.logWarn "Command: #{cmd} not found. Check '@globot help'"
    # msg.reply "Command: #{cmd} not found. Check '@globot help'"
