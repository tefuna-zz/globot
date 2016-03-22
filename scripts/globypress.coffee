# Description:
#   send globy press.
#
# Commands:
#   hubot globypress <press-id>

gc = require('globy-common')
fs = require('fs')
cronJob = require('cron').CronJob

RES_ROOT = "./resources/globypress"
ENCODING = "utf-8"
EXT = ".json"
WEBHOOK_URL = process.env.HUBOT_SLACK_WEBHOOK_URL

getPressJson = (pressId) ->
  content = ""
  if pressId?.trim()
    gc.log("INFO", "pressId: #{pressId}", null)
    content = fs.readFileSync RES_ROOT + "/#{pressId}" + EXT, ENCODING
  return content


sendPress = (content, robot) ->
  if content?.trim()
    gc.log("INFO", "url: #{WEBHOOK_URL}, content: #{content}", null)
    robot.http(WEBHOOK_URL)
      .header("Content-Type", "application/json")
      .post(content) (err, res, body) ->
      if err?
        res.send "globy press send failed: " + err
    return


module.exports = (robot) ->

  robot.respond /globypress (.+)/i, (msg) ->
    pressId = msg.match[1]
    sendPress(getPressJson(pressId), robot)

  new cronJob
    cronTime: "0 12 * * *"
    onTick: ->
      gc.log("DEBUG", "globypress: monthly/eom")
      sendPress(getPressJson("monthly/eom"), robot)
      return
    start: true
    timeZone: "Asia/Tokyo"

