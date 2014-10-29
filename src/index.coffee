
jc = require 'json-criteria'

matches = (a, t) ->
  switch typeof t

    when 'string'
      switch t

        when 'undefined', 'boolean', 'number', 'string', 'symbol', 'function', 'object'
          typeof a is t

        when 'array'
          Array.isArray a

        when 'object!'
          a? and typeof a is 'object'

        else
          a instanceof global[t]

    when 'function'
      t a

    when 'object'
      jc.test a, t

    else
      false

# Left-shift optional function arguments.
#
# @example
#   [ criteria, code, done ] = lshift [
#     [ criteria, 'object', {} ]
#     [ code, 'number', 200 ]
#     [ done, 'function' ]
#   ]
#
# @param [Array] as Arguments
# @return [Array] Shifted arguments
lshift = (as) ->
  r = []
  n = as.length
  i = 0
  j = 0
  while i < n
    ai = as[ i ]
    aj = as[ j ]

    # Support array and object notations
    if Array.isArray ai then [ vi, ti, di ] = ai else { vi, ti, di } = ai
    if Array.isArray aj then [ vj, tj, dj ] = aj else { vj, tj, dj } = aj

    if matches vj, ti
      # console.log 'y', vj, ti
      r.push vj
      i += 1
      j += 1
    else
      # console.log 'n'
      r.push di
      i += 1
  # console.log r
  r

# d = ->
# f = (onoff, msg, done) ->
#   [ onoff, msg, done ] = lshift [
#     [ onoff, { $in: [ 'on', 'off' ] }, 'off' ]
#     [ msg, 'string', null ]
#     [ done, 'function' ]
#   ]
#   [ onoff, msg, done ]
#
# f d

module.exports = {
  lshift
}
