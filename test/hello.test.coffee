# target: scripts/hello.coffee

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hello', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
    @msg =
      send: sinon.spy()

    require('../scripts/hello')(@robot)
    @robot.respond.firstCall.args[1](@msg)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/hello/i)

  it 'sends a message', ->
    expect(@msg.send).to.have.been.calledWith('Hello Shell.')
