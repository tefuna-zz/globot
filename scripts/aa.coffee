# Description
#   show AA.
#
# Dependencies:
#   "globy-common": "latest"
#
# Configuration:
#   None
#
# Commands:
#   hubot aa all - show all aa
#   hubot aa list - show list of aa name
#   hubot aa <aa name> - show aa
#   新鮮 - show aa fresh
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

# =============================================================================
# constants.
# =============================================================================
RES_ROOT = "./resources/aa"
EXT = ".aa"
CMD_AA_ALL = "ls -l #{RES_ROOT} | egrep \"#{EXT}$\" | " +
  " awk '{ sub(\"#{EXT}\", \"\", $9); print($9) }' | sort"
CMD_AA_LIST = "ls -l #{RES_ROOT} | egrep \"#{EXT}$\" | " +
  " awk '{ sub(\"#{EXT}\", \"\", $9); print $9, $6, $7, $8}' | sort"

# =============================================================================
# function: read aa file resource.
# =============================================================================
getAA = (aaName, bindMap) ->
  unless aaName?.trim()
    throw New Error "aaName is null."

  str = ""
  try
    str = gc.readResource "#{RES_ROOT}/#{aaName}#{EXT}", bindMap
    str = "." + str
  catch e
    gc.logInfo "aa not found: #{aaName}"
  return str

# =============================================================================
# robot main.
# =============================================================================
module.exports = (robot) ->

  #
  # hubot aa all
  #
  robot.respond /aa all$/i, (msg) ->
    promise = gc.execCommand CMD_AA_ALL
    promise.then (value) ->
      aaNames = value.split(/\r\n|\r|\n/)
      for aaName in aaNames
        msg.send aaName
        msg.send getAA aaName
      return
    # FIXME: rejectされた時のpromise.catchが正しく動かない。
    # .catch (error) ->
    #   throw new Error "command fail: #{error}"

  #
  # hubot aa list
  #
  robot.respond /aa list$/i, (msg) ->
    promise = gc.execCommand CMD_AA_LIST
    promise.then (value) ->
      msg.send value
    return

  #
  # hubot aa <aa name> <bind>...
  #
  robot.respond /aa ((?!all|list).*)$/i, (msg) ->
    args = msg.match[1].replace(/\s+/, " ").split(/\s/)
    bindMap =
      "bind1": args[1]
    response = getAA args[0], bindMap
    if response is ""
      response = "aa <#{args[0]}> not found."
    msg.send response
    return

  #
  # 新鮮
  #
  robot.hear /新鮮/, (msg) ->
    msg.send getAA "fresh"
    return
