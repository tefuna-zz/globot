# Description:
#   emittest
#
# Commands:
#   hubot emittest

fs = require('fs')
exec = require('child_process').exec
util = require('util')
slack = require('hubot-slack')


module.exports = (robot) ->
  robot.respond /emittest/i, (msg) ->
    unless robot.adapter instanceof slack.SlackBot
      msg.send "hogehoge"
    else
      util.log("aaaaaaaaaaaa")
      robot.emit 'slack.attachment',
        message: msg.message
        content: [{
          text: "Attachment text"
          fallback: "Attachment fallback"
          fields: [{
            title: "Field title"
            value: "Field value"
          }]
        }, {
          pretext: "[Pretext] *bold text* _italic text_ `fixed-width text`"
          color: "#439FE0"
          mrkdwn_in: ["text", "pretext", "fields"]
          text: """
                ・ *bold test*
                ・ _italic text_
                ・ `fixed-witdh text`
                > block quote
                ```
                #include <iostream>
                using namespace std%3B
                void main() {
                  cout << \"hello world\" << endl%3B
                }
                ```
                """
          fields: [{
            title: "Field 1"
            value: "*bold text* _italic text_ `fixed-witdh text`"
            short: 1
          }, {
            title: "Field 2"
            value: "*bold text* _italic text_ `fixed-witdh text`"
            short: 1
          }]
        }]
        ername: "foobot" # optional, defaults to robot.name
        icon_url: "..." # optional
        icon_emoji: "..." # optional
