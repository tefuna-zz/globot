# Description:
#   globot common functions.

util = require('util')
hubot = require('hubot')

LOG_LEVEL_DEFAULT = "WARN"


#
# logging and send message to slack.
#
log = (level, message, slackObj) ->
  unless level?
    level = LOG_LEVEL_DEFAULT
  unless message?
    return

  logmsg  = "[" + level + "] " + message
  util.log(logmsg)
  if slackObj instanceof hubot.Robot
    slackObj.send {room: "globot-test"}, logmsg
  else if slackObj instanceof hubot.Response
    slackObj.send logmsg


########################################################
# export
########################################################
module.exports.log = log
