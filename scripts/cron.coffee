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
      robot.send {room: "globot-test"}, "cron test #{new Date()} お昼になりました。"
      return
    start: true
    timeZone: "Asia/Tokyo"

