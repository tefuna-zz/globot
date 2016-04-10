# Description:
#   monitor all mentions.
#
# Commands:
# 

gc = require('globy-common')
util = require('util')

module.exports = (robot) ->

  robot.hear /(.+)/, (msg) ->
    util.log("[DEBUG] " + JSON.stringify(msg.envelope.message, null, "  "))
    #gc.log("DEBUG", "put into es...", msg)
    #msg.envelope.message.user.slack.profile = null
    #gc.log("DEBUG", JSON.stringify(msg.envelope.message, null, "  "), msg)

