(function() {
  var jc, lshift, matches;

  jc = require('json-criteria');

  matches = function(a, t) {
    switch (typeof t) {
      case 'string':
        switch (t) {
          case 'undefined':
          case 'boolean':
          case 'number':
          case 'string':
          case 'symbol':
          case 'function':
          case 'object':
            return typeof a === t;
          case 'object!':
            return (a != null) && typeof a === 'object';
          default:
            return a instanceof global[t];
        }
        break;
      case 'function':
        return t(a);
      case 'object':
        return jc.test(a, t);
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
      if (matches(vj, ti)) {
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
    lshift: lshift
  };

}).call(this);
