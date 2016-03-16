# Description:
#   update bot resources from github.
#
# Commands:
#   bot botupdate - pull from git repository and update scripts
#   bot botrestart - restart globot process

exec = require('child_process').exec
util = require('util')

module.exports = (robot) ->

  wait = (time) ->
    $.Deferred (defer) ->
      setTimeout ->
        defer.resolve()
      , time


  #
  # botupdate - bot update sync github repository.
  # 
  robot.respond /botupdate$/i, (msg) ->
    command = "git pull"
    msg.send "cmd: #{command}"
    exec command, (error, stdout, stderr) ->
      try
        if error
          msg.send "botupdate failed: " + stderr
        else
          output = stdout + ''
          if not "Already up-to-date." ==  output
            msg.send stdout
            msg.send "globot updated !!"
          else
            msg.send "globot already up-to-date."
      catch error
        msg.send "botupdate failed: " + error
      util.log("cmd: #{command} \n" + stdout)
    return


  #
  # botrestart - bot process restart.
  #
  robot.respond /botrestart$/i, (msg) ->
    command = "./run.sh restart"
    msg.send "cmd: #{command}"
    msg.send "Wait a minute...  Please type \"@globot: ping\" if you cannot receive complete message."
    exec command, (error, stdout, stderr) ->
      try
        if error
          msg.send "botrestart failed: " + stderr
          util.log("botrestart failed: " + stderr)
        else
          wait(30000).done => util.log("wait complete")
          msg.send stdout
          msg.send "globot restart finished."
          util.log("globot restart finished.")
      catch error
        msg.send "botrestart failed: " + error
        util.log("cmd: #{command} \n" + error)
    return 

