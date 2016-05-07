# Description
#   hello hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot hello - show your username
#
# Notes:
#   None
#
# Author:
#   globy

# =============================================================================
# robot main.
# =============================================================================
module.exports = (robot) ->

  #
  # hubot hello
  #
  robot.respond /hello/i, (msg) ->
    msg.send "Hello #{msg.message.user.name}."
    return
