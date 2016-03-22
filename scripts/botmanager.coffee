# Description:
#   globot control process.
#
# Commands:
#   hubot botupdate - pull from git repository and update scripts
#   hubot botrestart - restart globot process

gc = require('globy-common')
exec = require('child_process').exec
cronJob = require('cron').CronJob

CMD_BOTUPDATE = "git pull"
CMD_BOTRESTART = "./run.sh restart"


module.exports = (robot) ->

  # TODO 動かない
  robot.enter (msg) ->
    gc.log("INFO", "handle enter message.", msg)

  # TODO 動かない
  robot.leave (msg) ->
    gc.log("INFO", "handle leave message.", msg)


  #
  # botupdate - bot update sync github repository.
  #
  robot.respond /botupdate$/i, (msg) ->
    gc.log("INFO", "cmd: #{CMD_BOTUPDATE}", msg)
    exec CMD_BOTUPDATE, (error, stdout, stderr) ->
      try
        if stderr?
          gc.log("INFO", "botupdate failed: " + stderr, msg)
        else
          msg.send stdout
          msg.send "globot updated !!"
      catch error
        gc.log("INFO", "botupdate failed: " + error, msg)
    return


  #
  # botrestart - bot process restart.
  #
  robot.respond /botrestart$/i, (msg) ->
    gc.log("INFO", "cmd: #{CMD_BOTRESTART}", msg)
    exec CMD_BOTRESTART, (error, stdout, stderr) ->
      try
        if stderr?
          gc.log("INFO", "botrestart failed: " + stderr, msg)
        else
          msg.send stdout
          msg.send "globot restart finished."
      catch error
        gc.log("INFO", "botrestart failed: " + error, msg)
    return


  #
  # run when globot start, run only once.
  #
  initJob = new cronJob
    cronTime: "* * * * *"
    onTick: ->
      gc.log("DEBUG", "globot init script begin.", robot)
      robot.send {room: "globot-test"}, "globot: 初期化処理を実行しています。"
      robot.send {room: "globot-test"}, "globot: モニタリングを開始しました。"
      # any init process, write here.
      robot.send {room: "globot-test"}, "globot: 起動しました。#{new Date()}"
      initJob.stop()
      gc.log("DEBUG", "globot init script end.", robot)
      return
    start: true
    timeZone: "Asia/Tokyo"

