#!/bin/bash

set -e
source ./setenv.sh

npm install
export PATH="node_modules/.bin:$PATH"

node node_modules/.bin/mocha
