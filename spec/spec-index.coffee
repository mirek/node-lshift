
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
