# Description
#   manage hubot process.
#
# Dependencies:
#   "globy-common": "latest"
#   "cron": "latest"
#
# Configuration:
#   HUBOT_SLACK_DEFAULT_ROOM
#
# Commands:
#   init - initialize hubot at startup.
#   hubot botupdate - pull from git repository and update scripts
#   hubot botrestart - restart globot process
#
# Notes:
#   None
#
# Author:
#   globy

# =============================================================================
# imports.
# =============================================================================
gc = require 'globy-common'
cronJob = require('cron').CronJob

# =============================================================================
# constants.
# =============================================================================
CMD_BOTUPDATE = "git pull"
CMD_BOTRESTART = "./run.sh restart"
ROOM = process.env.HUBOT_SLACK_DEFAULT_ROOM

# =============================================================================
# function: hubot init script
# =============================================================================
initBot = (robot) ->
  gc.logInfo "globot init script begin."
  robot.send {room: ROOM}, "#{gc.now()} globot: 初期化処理を実行しています。"
  robot.send {room: ROOM}, "#{gc.now()} globot: モニタリングを開始しました。"
  robot.send {room: ROOM}, "#{gc.now()} globot: 起動しました。"
  gc.logInfo "globot init script end."
  return

# =============================================================================
# robot main.
# =============================================================================
module.exports = (robot) ->

  #
  # init: run at once startup.
  #
  initBot(robot)

  #
  # hubot botupdate
  #
  robot.respond /botupdate$/i, (msg) ->
    promise = gc.execCommand CMD_BOTUPDATE
    promise.then (value) ->
      msg.send stdout
      msg.send "globot updated."
    return
    # FIXME: reject activity.
    # if stderr
    #   gc.log("INFO", "botupdate failed: " + stderr, msg)

  #
  # hubot botrestart
  #
  robot.respond /botrestart$/i, (msg) ->
    promise = gc.execCommand CMD_BOTRESTART
    promise.then (value) ->
      msg.send stdout
      msg.send "globot restart finished."
    return
    # FIXME: reject activity.
