
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

    if ((typeof ti is 'string') and (typeof vj is ti)) or ((typeof ti is 'function') and (vj instanceof ti))
      r.push vj
      i += 1
      j += 1
    else
      r.push di
      i += 1
  r

module.exports = {
  lshift
}
