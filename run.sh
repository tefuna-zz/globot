#!/bin/bash

set -e

BOT_ROOT=/opt/hubot/globot

npm install
export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"

# config - globy slack.
export HUBOT_SLACK_TOKEN="xoxb-26449935988-Jk4EmlAqEb2MCUOh7ng4B7bv"
export PORT=10080

# config - twitter watch.
export HUBOT_TWITTER_CONSUMER_KEY="2GoZ6fFyFI10ayEm7HIduBLmU"
export HUBOT_TWITTER_CONSUMER_SECRET="XywDuZrbUhijl6Pf8r4ZIpn09zCtf5H3wv9DFkwMbAHuLs3Pzu"
export HUBOT_TWITTER_ACCESS_TOKEN_KEY="16151512-yBqBS61YcDv12Bbm30c0TkHwGKihxOCtF7nHl7sKp"
export HUBOT_TWITTER_ACCESS_TOKEN_SECRET="9Dtw4bBq7vtDARdsYPCIG3PSqO86GoqW7y8srPUc2pBGV"
export HUBOT_TWITTER_MENTION_QUERY="ラーメン"
export HUBOT_TWITTER_MENTION_ROOM="globot-test"

case ${1} in
  "start" | "stop" | "restart" )
    forever ${1} --pidFile ${BOT_ROOT}/../pid/globot.pid -l ${BOT_ROOT}/../logs/globot.log --append -c coffee node_modules/.bin/hubot --adapter slack
    ;;
  * )
    echo "Usage: globot.sh (start|stop|restart)"
    ;;
esac

