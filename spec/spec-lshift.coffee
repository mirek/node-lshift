
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
          [ onoff, 'boolean', false ]
          [ msg, 'string', null ]
          [ done, 'function' ]
        ]
        [ onoff, msg, done ]

      assert.deepEqual [ false, null, d ], f d
      assert.deepEqual [ true, null, d ], f true, d
      assert.deepEqual [ false, null, d ], f false, d
      assert.deepEqual [ false, 'message', d ], f 'message', d
      assert.deepEqual [ true, 'message', d ], f true, 'message', d

  describe 'other tests', ->

    it 'should work with array', ->

      d = ->
      f = (str, arr, func) ->
        [ str, arr, func ] = $.lshift [
          [ str, 'string', 'foo' ]
          [ arr, 'array', [] ]
          [ func, 'function' ]
        ]

      assert.deepEqual [ 'foo', [], undefined ], f()
      assert.deepEqual [ 'bar', [], undefined ], f 'bar'
      assert.deepEqual [ 'foo', [ 1, 2, 3 ], undefined ], f [ 1, 2, 3]
      assert.deepEqual [ 'foo', [], d ], f d
      assert.deepEqual [ 'foo', [ 1 ], d ], f [ 1 ], d
      assert.deepEqual [ 'bar', [ 1 ], d ], f 'bar', [ 1 ], d
