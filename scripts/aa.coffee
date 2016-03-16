# Description:
#   show AA.
#
# Commands:
#   bot aa <aa name> - show aa
#   bot aa list - show list of aa name
#   bot aa all - show all aa

RES_ROOT="./resources/aa"
ENCODING="utf8"
EXT=".txt"


fs = require 'fs'
exec = require('child_process').exec
util = require('util')


getAA = (aaName, bind) ->
  str = ""
  if aaName?.trim()
    util.log("aaName: #{aaName}, bind: #{bind}")
    str = fs.readFileSync RES_ROOT + "/#{aaName}" + EXT, ENCODING
    if !bind?.trim()
      bind = ""
    str = str.replace(/#{bind}/, "#{bind}")
    str = ".\n" + str
  return str


module.exports = (robot) ->

  robot.respond /AA ALL$/i, (msg) ->
    command = "ls -l #{RES_ROOT} | egrep \.txt$ | awk '{ sub(\".txt\", \"\", $9); print($9) }' | sort"
    msg.send "cmd: #{command}"
    exec command, (error, stdout, stderr) ->
      msg.send error if error?
      msg.send stderr if stderr?
      aaNames = stdout.split(/\r\n|\r|\n/)
      for aaName in aaNames
        msg.send "#{aaName}"
        msg.send getAA(aaName, "")
    return

  robot.respond /AA LIST$/i, (msg) ->
    command = "ls -l #{RES_ROOT} | egrep \.txt$ | awk '{ sub(\".txt\", \"\", $9); print $9\"\t\"$6, $7, $8}' | sort"
    msg.send "cmd: #{command}"
    exec command, (error, stdout, stderr) ->
      msg.send error if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?
    return 

  robot.respond /AA ((?!ALL|LIST).*)$/i, (msg) ->
    args = msg.match[1].replace(/\s+/, " ").split(/\s/)
    util.log("args: " + args)
    msg.send getAA(args[0], args[1])
    return

