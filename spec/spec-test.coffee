
assert = require 'assert'
$ = require '../src'

t = (a, q, args...) -> assert.equal true, $.test(a, q), args...
f = (a, q, args...) -> assert.equal false, $.test(a, q), args...

describe 'test', ->

  it 'should test for nulls', ->
    t null, 'null'
    f 0, 'null'
    t 'foo', $not: 'null'

  it 'should test for strings', ->
    t 'foo', 'string'
    f 1, 'string'
    t {'foo':'bar'}, $not: 'string'

  it 'should test for numbers', ->
    t 1, 'number'
    t 1.1, 'number'
    f '1', 'number'

  it 'should test for arrays', ->
    f {}, 'array'
    t [], 'array'
    t {}, $not: 'array'

  it 'should test for objects', ->
    t [], 'object'
    f '', 'object'
    t null, 'object'

  it 'should test for functions', ->
    t (->), 'function'
    f null, 'function'
    t undefined, $or: [ 'function', 'undefined' ]
    t (->), $or: [ 'function', 'undefined' ]
    f true, $or: [ 'function', 'undefined' ]

  it 'should test for $and, $or, $not', ->
    t 'foo', $and: [ 'string', $not: 'null' ]
    f 1, $and: [ 'string', $not: 'null' ]
    t 'foo', $or: [ 'number', 'string' ]
    t 1, $or: [ 'number', 'string' ]
    f true, $or: [ 'number', 'string' ]
