# Description:
#   cron task script.
#
# Commands:
#

gc = require('globy-common')
fs = require('fs')
cronJob = require('cron').CronJob

RES_ROOT = "./resources/notification"
ENCODING = "utf-8"
EXT = ".json"
WEBHOOK_URL = process.env.HUBOT_SLACK_WEBHOOK_URL
ES_URL = process.env.ELASTICSEARCH_URL
ES_QUERY_PATH = "ssh-access-*/ssh.access/_search"


getQuery = (id) ->
  query = ""
  if id?.trim()
    gc.log("INFO", "id: #{id}", null)
    query = fs.readFileSync RES_ROOT + "/#{id}" + EXT, ENCODING
  return query


executeQuery = (path, query) ->
  gc.log("INFO", "url: #{ES_URL}#{path}, query: #{query} ", null)
  robot.http(WEBHOOK_URL)
    .header("Content-Type", "application/json")
    .get(content) (err, res, body) ->
    if err?
      res.send "globy press send failed: " + err
    gc.log("INFO", res)
  return res


sendAlert = (content, robot) ->
  if content?.trim()
    gc.log("INFO", "url: #{WEBHOOK_URL}, content: #{content}", null)
    robot.http(WEBHOOK_URL)
      .header("Content-Type", "application/json")
      .post(content) (err, res, body) ->
      if err?
        res.send "globy press send failed: " + err
    return


module.exports = (robot) ->

  new cronJob
    cronTime: "5 * * * *"
    onTick: ->
      gc.log("DEBUG", "notification: ssh/login-failed")
      query = getQuery("ssh/q-login-failed")
      res = executeQuery()
      return
    start: true
    timeZone: "Asia/Tokyo"
