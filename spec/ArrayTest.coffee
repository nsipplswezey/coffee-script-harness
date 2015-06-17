chai = require 'chai'

###
import external modules for testing here
###
Promise = require '../index.coffee'

describe 'Array', ->
  describe '#indexOf()', ->
    it 'should return -1 when not present', ->
      chai.expect([1,2,3].indexOf(4)).to.eql(-1)

describe 'Promise', ->
  describe 'Export', ->
    it 'should have access to a Promise function', ->
      chai.expect(Promise).to.be.a('function')
