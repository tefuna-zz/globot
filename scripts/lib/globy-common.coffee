# Description
#   globot common functions.
#
# Dependencies:
#   "util": "latest"
#   "moment": "latest"
#   "fs": "latest"
#   "exec": "latest"
#
# Configuration:
#   HUBOT_SLACK_WEBHOOK_URL
#
# Commands:
#   None
#
# Notes:
#   None
#
# Author:
#   globy

# =============================================================================
# imports.
# =============================================================================
util = require 'util'
moment = require 'moment'
fs = require 'fs'
exec = require('child_process').exec
Promise = require('es6-promise').Promise
client = require 'cheerio-httpcli'

# =============================================================================
# constants.
# =============================================================================
DATE_FORMAT = "YYYY-MM-DD HH:mm:ss"
LOG_LEVEL =
  DEBUG: "DEBUG"
  INFO: "INFO"
  WARN: "WARN"
  ERROR: "ERROR"
  FATAL: "FATAL"
ENCODING = "utf-8"
WEBHOOK_URL = process.env.HUBOT_SLACK_WEBHOOK_URL

# =============================================================================
# initialization.
# =============================================================================
moment.locale('ja')
client.setBrowser('chrome')

###*
# logging date, level and log message.
# @param {string} level
# @param {string} message
###
log = (level = LOG_LEVEL.WARN, message) ->
  unless message?
    throw new Error "message should not be null."
  util.log "[#{level}] #{message}"
  return

logDebug = (message) ->
  log LOG_LEVEL.DEBUG, message
  return

logInfo = (message) ->
  log LOG_LEVEL.INFO, message
  return

logWarn = (message) ->
  log LOG_LEVEL.WARN, message
  return

logError = (message) ->
  log LOG_LEVEL.ERROR, message
  return

logFatal = (message) ->
  log LOG_LEVEL.FATAL, message
  return


###*
# get formatted timestamp string.
# @param {string} format
# @return {string} timestamp
###
now = (format = DATE_FORMAT) ->
  return moment().format(format)


###*
# escape json string.
# @param {string} str
# @return {string} escaped string
###
escapeJson = (str) ->
  return str.replace(/"/g, "\\\"")


###*
# read file resource, return as string.
# @param {string} path
# @param {string} bindMap
# @return {string} resource string
###
readResource = (path, bindMap) ->
  logInfo "path: #{path}, bindMap: " + JSON.stringify(bindMap)
  str = fs.readFileSync path, ENCODING
  if bindMap?
    str = bindStr str, bindMap
  logInfo str
  return str


###*
# bind parameter to str as name of bind key.
# @param {string} str
# @param {string} bindMap
# @return {string} string binded
###
bindStr = (str, bindMap) ->
  for key, value of bindMap
    regExp = new RegExp '#{' + "#{key}" + '}', "g"
    str = str.replace(regExp, "#{value}")
  return str


###*
# send message to slack webhook.
# @param {string} content
# @param {Robot} robot
# @return {string} string binded
###
sendMessage = (content, robot, webhookUrl = WEBHOOK_URL) ->
  unless content?
    throw new Error "content should not be null."

  logInfo "url: #{webhookUrl}, content: #{content}"
  robot.http webhookUrl
    .header "Content-Type", "application/json"
    .post content (err, res, body) ->
      if err?
        logError "send message with webhook failed: #{err}"
    return


###*
# execute native command asynchronous. return Promise ojbect.
# @param {string} command
# @return {Promise} execute async
###
execCommand = (command) ->
  unless command?
    throw new Error "command should not be null."

  logInfo "cmd: #{command}"
  return new Promise (resolve, reject) ->
    exec command, (error, stdout, stderr) ->
      if stdout?
        resolve stdout
      if error?
        reject error
      if stderr?
        reject stderr
      return


###*
# execute native command asynchronous. return Promise ojbect.
# @param {string} command
# @return {Promise} execute async
###
fetchPage = (url) ->
  unless url?
    throw new Error "url should not be null."

  logInfo "url: #{url}"
  return new Promise (resolve, reject) ->
    client.fetch url, {}, (err, $, res) ->
      if $?
        resolve $
      if err?
        reject err
      return


# =============================================================================
# module exports.
# =============================================================================
module.exports.logDebug = logDebug
module.exports.logInfo = logInfo
module.exports.logWarn = logWarn
module.exports.logError = logError
module.exports.logFatal = logFatal
module.exports.now = now
module.exports.escapeJson = escapeJson
module.exports.readResource = readResource
module.exports.sendMessage = sendMessage
module.exports.execCommand = execCommand
module.exports.fetchPage = fetchPage
