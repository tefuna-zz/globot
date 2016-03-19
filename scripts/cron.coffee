# Description:
#   cron task script.
#
# Commands:
#

cronJob = require('cron').CronJob

module.exports = (robot) ->
  new cronJob
    cronTime: "00 12 * * *"
    onTick: ->
      robot.send {room: "globot-test"}, "globot cron test #{new Date()} お昼になりました。"
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "30 9 * * *"
    onTick: ->
      robot.send {room: "globot-test"}, "globot cron test #{new Date()} 始業時間です。今日もはりきって。"
      return
    start: true
    timeZone: "Asia/Tokyo"

  new cronJob
    cronTime: "30 17 * * *"
    onTick: ->
      robot.send {room: "globot-test"}, "globot cron test #{new Date()} 終業時間です。今日もはりきって。"
      return
    start: true
    timeZone: "Asia/Tokyo"
