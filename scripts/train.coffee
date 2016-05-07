# Description
#   announce train information.
#
# Dependencies:
#   "globy-common": "latest"
#
# Configuration:
#   None
#
# Commands:
#   hubot train - send train running status.
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
TRAIN_JR_URL = "http://traininfo.jreast.co.jp/train_info/kanto.aspx"
TRAIN_TM_URL = "http://www.tokyometro.jp/index.html"
WEBHOOK_URL = process.env.HUBOT_SLACK_WEBHOOK_URL
ROOM = process.env.HUBOT_SLACK_DEFAULT_ROOM

# =============================================================================
# robot main.
# =============================================================================
module.exports = (robot) ->

  #
  # hubot train
  # FIXME: promiseの多段が動かない。htmlのパースとレスポンス形式の見直し
  robot.respond /train/i, (msg) ->
    promise = gc.fetchPage TRAIN_JR_URL
    promise.then ($) ->
      # parse response
      $('#direction_soubu > tbody > tr').each ->
        tr = $ @
        rail = tr.find('th').text()
        status = tr.find('td > img').attr('alt')

        if rail is "総武快速線" or rail is "総武本線"
          gc.logInfo "rail: #{rail}, status: #{status}"
          robot.send {room: ROOM}, "#{rail}: #{status}"
