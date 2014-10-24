
assert = require 'assert'
$ = require '../src'

describe 'lshift', ->

  it 'should shift args', ->

    f = (path_, code, criteria, done) ->
      [ code, criteria, done ] = $.lshift [
        [ code, 'number', 200 ]
        [ criteria, 'object', {} ]
        [ done, 'string' ]
      ]
      [ path_, code, criteria, done ]

    assert.deepEqual [ 'hello', 200, {}, undefined ], f 'hello'
    assert.deepEqual [ 'hello', 500, {}, undefined ], f 'hello', 500
    assert.deepEqual [ 'hello', 500, { a: 1 }, undefined ], f 'hello', 500, { a: 1 }
    assert.deepEqual [ 'hello', 500, { a: 1 }, '->' ], f 'hello', 500, { a: 1 }, '->'

    assert.deepEqual [ 'hello', 200, { a: 1 }, undefined ], f 'hello', { a: 1 }
    assert.deepEqual [ 'hello', 200, { a: 1 }, '->' ], f 'hello', { a: 1 }, '->'

    assert.deepEqual [ 'hello', 200, {}, '->' ], f 'hello', '->'

  describe 'readme example', ->

    func = ->

    find = (oid, options, done) ->
      [ oid, options, done ] = $.lshift [
        [ oid, 'string', 'N/A' ]
        [ options, 'object', {} ]
        [ done, 'function' ]
      ]
      [ oid, options, done ]

    it 'should work with combination #1', ->
      assert.deepEqual [ '123', {}, undefined ], find '123'

    it 'should work with combination #2', ->
      assert.deepEqual [ '123', { a: 1 }, undefined ], find '123', { a: 1 }

    it 'should work with combination #3', ->
      assert.deepEqual [ '123', { a: 1 }, func ], find '123', { a: 1 }, func

    it 'should work with combination #4', ->
      assert.deepEqual [ 'N/A', { a: 1 }, undefined ], find { a: 1 }

    it 'should work with combination #5', ->
      assert.deepEqual [ 'N/A', { a: 1 }, func ], find { a: 1 }, func

    it 'should work with combination #6', ->
      assert.deepEqual [ 'N/A', {}, func ], find func

    it 'should work with combination #7', ->
      assert.deepEqual [ 'N/A', {}, undefined ], find()

  describe 'json criteria', ->

    it 'should work', ->

      d = ->
      f = (onoff, msg, done) ->
        [ onoff, msg, done ] = $.lshift [
          [ onoff, { $in: [ 'on', 'off' ] }, 'off' ]
          [ msg, 'string', null ]
          [ done, 'function' ]
        ]
        [ onoff, msg, done ]

      assert.deepEqual [ 'off', null, d ], f d
      assert.deepEqual [ 'on', null, d ], f 'on', d
      assert.deepEqual [ 'off', null, d ], f 'off', d
      assert.deepEqual [ 'off', 'message', d ], f 'message', d
      assert.deepEqual [ 'on', 'message', d ], f 'on', 'message', d
