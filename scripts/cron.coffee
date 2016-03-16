# Description:
#   cron task script.
#
# Commands:
#

cronJob = require('cron').CronJob

module.exports = (robot) ->
  new cronJob
    cronTime: "30 */1 * * *"
    onTick: -> 
      robot.send {room: "globot-test"}, "cron test #{new Date()} あああ"
      return
    start: true
    timeZone: "Asia/Tokyo"

