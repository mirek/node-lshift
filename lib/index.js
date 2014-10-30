(function() {
  var lshift, test;

  test = function(d, q) {
    var k, klass, s, v;
    switch (typeof q) {
      case 'string':
        switch (q) {
          case 'undefined':
          case 'boolean':
          case 'number':
          case 'string':
          case 'symbol':
          case 'function':
          case 'object':
            return typeof d === q;
          case 'null':
            return d == null;
          case 'array':
            return Array.isArray(d);
          default:
            if ((klass = global[q]) != null) {
              return d instanceof klass;
            } else {
              return false;
            }
        }
        break;
      case 'function':
        return !!q(d);
      case 'object':
        s = true;
        for (k in q) {
          v = q[k];
          s = s && (function() {
            switch (k) {
              case '$and':
                return v.reduce((function(p, c) {
                  return p && test(d, c);
                }), true);
              case '$or':
                return v.reduce((function(p, c) {
                  return p || test(d, c);
                }), false);
              case '$nor':
                return v.reduce((function(p, c) {
                  return p && !test(d, c);
                }), true);
              case '$not':
                return !test(d, v);
              default:
                return test(d, v);
            }
          })();
          if (!s) {
            break;
          }
        }
        return s;
      default:
        return false;
    }
  };

  lshift = function(as) {
    var ai, aj, di, dj, i, j, n, r, ti, tj, vi, vj;
    r = [];
    n = as.length;
    i = 0;
    j = 0;
    while (i < n) {
      ai = as[i];
      aj = as[j];
      if (Array.isArray(ai)) {
        vi = ai[0], ti = ai[1], di = ai[2];
      } else {
        vi = ai.vi, ti = ai.ti, di = ai.di;
      }
      if (Array.isArray(aj)) {
        vj = aj[0], tj = aj[1], dj = aj[2];
      } else {
        vj = aj.vj, tj = aj.tj, dj = aj.dj;
      }
      if (test(vj, ti)) {
        r.push(vj);
        i += 1;
        j += 1;
      } else {
        r.push(di);
        i += 1;
      }
    }
    return r;
  };

  module.exports = {
    test: test,
    lshift: lshift
  };

}).call(this);
