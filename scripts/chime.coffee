# Description
#   send regular announcement by cronjob.
#
# Dependencies:
#   "globy-common": "latest"
#   "cron: "latest"
#
# Configuration:
#   HUBOT_SLACK_DEFAULT_ROOM
#
# Commands:
#   None
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
ROOM = process.env.HUBOT_SLACK_DEFAULT_ROOM

# =============================================================================
# robot main.
# =============================================================================
module.exports = (robot) ->

  new cronJob
    cronTime: "30 9 * * 1-5"
    onTick: ->
      robot.send {room: ROOM}, "#{gc.now()} 始業時間になりました。"
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "00 12 * * 1-5"
    onTick: ->
      robot.send {room: ROOM}, "#{gc.now()} お昼になりました。"
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "30 17 * * 1-5"
    onTick: ->
      robot.send {room: ROOM}, "#{gc.now()} 終業時間になりました。"
    start: true
    timeZone: "Asia/Tokyo"
