chai = require 'chai'

###
import external modules for testing here
###

describe 'Array', ->
  describe '#indexOf()', ->
    it 'should return -1 when not present', ->
      chai.expect([1,2,3].indexOf(4)).to.eql(-1)
