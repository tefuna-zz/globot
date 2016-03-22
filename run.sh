#!/bin/bash

set -e
source ./setenv.sh

npm install
export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"

case ${1} in
  "start" | "stop" | "restart" )
    forever ${1} --pidFile ${BOT_ROOT}/../pid/globot.pid -l ${BOT_ROOT}/../logs/globot.log --append -c coffee node_modules/.bin/hubot --adapter slack
    ;;
  * )
    echo "Usage: globot.sh (start|stop|restart)"
    ;;
esac

