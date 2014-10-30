
# @param d Value
# @param q Query
# @return [Boolean]
test = (d, q) ->
  switch typeof q

    when 'string'
      switch q

        # Know
        when 'undefined', 'boolean', 'number', 'string', 'symbol', 'function', 'object'
          typeof d is q

        # Extra pseudo-type for null check
        when 'null'
          not d?

        # Extra pseudo-type for array check
        when 'array'
          Array.isArray d

        else
          if (klass = global[q])?
            d instanceof klass
          else

            # TODO: Throw exception?
            false

    # Call function and force boolean result
    when 'function'
      not not q d

    # Solve query
    when 'object'
      s = true
      for k, v of q
        s = s and switch k
          when '$and' then v.reduce ((p, c) -> p and test(d, c)), true
          when '$or' then v.reduce ((p, c) -> p or test(d, c)), false
          when '$nor' then v.reduce ((p, c) -> p and not test(d, c)), true
          when '$not' then not test(d, v)
          else test d, v
        break unless s
      s

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

    if test vj, ti
      r.push vj
      i += 1
      j += 1
    else
      r.push di
      i += 1
  unless n is r.length
    throw new TypeError "Invalid number of arguments - expected #{n}, got #{r.length}."
  for e, k in as
    unless test r[k], e[1]
      throw new TypeError "Argument #{k + 1} of #{n} doesn't match #{JSON.stringify e[1]}, the type is #{JSON.stringify typeof r[k]}."
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
  test
  lshift
}
