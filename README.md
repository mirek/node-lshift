
## Summary [![Build Status](https://travis-ci.org/mirek/node-lshift.png?branch=master)](https://travis-ci.org/mirek/node-lshift)

Left-shift optional function arguments:

## Installation

    npm install lshift --save

## Example

    { lshift } = require 'lshift'

    find = (oid, options, done) ->
      [ oid, options, done ] = lshift [
        [ oid, 'string', 'N/A' ]
        [ options, 'object', {} ]
        [ done, 'function' ]
      ]
      # ...use oid, options and done as expected.
      [ oid, options, done ]

    find '123'               # [ '123', {}, undefined ]
    find '123', { a: 1 }     # [ '123', { a: 1 }, undefined ]
    find '123', { a: 1 }, -> # [ '123', { a: 1 }, -> ]
    find { a: 1 }            # [ 'N/A', { a: 1 }, undefined ]
    find { a: 1 }, ->        # [ 'N/A', { a: 1 }, -> ]
    find ->                  # [ 'N/A', {}, -> ]
    find()                   # [ 'N/A', {}, undefined ]

More advanced example is using JSON criteria for MongoDB-like criteria queries:

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

See specs for more usage examples.

## License

    The MIT License (MIT)

    Copyright (c) 2014 Mirek Rusin http://github.com/mirek

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
