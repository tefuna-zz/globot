# Description:
#   show AA.
#
# Commands:
#   hubot aa <aa name> - show aa
#   hubot aa list - show list of aa name
#   hubot aa all - show all aa

gc = require('globy-common')
fs = require('fs')
exec = require('child_process').exec

RES_ROOT = "./resources/aa"
ENCODING = "utf8"
EXT = ".txt"

CMD_AA_ALL = "ls -l #{RES_ROOT} | egrep \.txt$ | awk '{ sub(\".txt\", \"\", $9); print($9) }' | sort"
CMD_AA_LIST = "ls -l #{RES_ROOT} | egrep \.txt$ | awk '{ sub(\".txt\", \"\", $9); print $9, $6, $7, $8}' | sort"


getAA = (aaName, bind) ->
  str = ""
  if aaName?.trim()
    gc.log("INFO", "aaName: #{aaName}, bind: #{bind}" ,null)
    str = fs.readFileSync RES_ROOT + "/#{aaName}" + EXT, ENCODING
    if !bind?.trim()
      bind = ""
    str = str.replace(/#{bind}/, "#{bind}")
    str = "." + str
  return str


module.exports = (robot) ->

  robot.respond /AA ALL$/i, (msg) ->
    gc.log("INFO", "cmd: #{CMD_AA_ALL}", msg)
    exec CMD_AA_ALL, (error, stdout, stderr) ->
      msg.send error if error?
      msg.send stderr if stderr?

      aaNames = stdout.split(/\r\n|\r|\n/)
      for aaName in aaNames
        msg.send "#{aaName}"
        msg.send getAA(aaName, "")
    return

  robot.respond /AA LIST$/i, (msg) ->
    gc.log("INFO", "cmd: #{CMD_AA_LIST}", msg)
    exec CMD_AA_LIST, (error, stdout, stderr) ->
      msg.send error if error?
      msg.send stdout if stdout?
      msg.send stderr if stderr?
    return

  robot.respond /AA ((?!ALL|LIST).*)$/i, (msg) ->
    args = msg.match[1].replace(/\s+/, " ").split(/\s/)
    gc.log("INFO", "args: #{args}", msg)
    msg.send getAA(args[0], args[1])
    return

  #
  # for test.
  #
  robot.hear /新鮮/, (msg) ->
    msg.send getAA("fresh", null)
    return
