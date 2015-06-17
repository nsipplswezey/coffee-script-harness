(function() {
  var PENDING, Promise;

  console.log("Hello world!");

  PENDING = 0;

  PENDING = 1;

  PENDING = 2;

  Promise = function() {
    var doResolve, fulfill, getThen, handlers, reject, resolve, state, value;
    state = pending;
    value = null;
    handlers = [];
    fulfill = function(result) {
      state = FULFILLED;
      value = result;
    };
    reject = function(error) {
      state = REJECTED;
      value = error;
    };
    resolve = function(result) {
      var e, next;
      try {
        next = getNext(result);
        if (next) {
          doResolve(next.bind(result)(resolve(reject)));
          return;
        }
        fulfill(result);
      } catch (_error) {
        e = _error;
        reject(e);
      }
    };
    getThen = function(value) {
      var next, t;
      t = typeof value;
      if (value && (t === 'object' || t === 'function')) {
        next = value.next;
      }
      if (typeof next === 'function') {
        next;
      }
      return null;
    };
    return doResolve = function(fn, onFulfilled, onRejected) {
      var done, ex;
      done = false;
      try {
        return fn(function(value) {
          if (done) {
            return;
          }
          done = true;
          return onFulfilled(value);
        }, function(reason) {
          if (done) {
            return;
          }
          done = true;
          return onRejected(reason);
        });
      } catch (_error) {
        ex = _error;
        if (done) {
          return;
        }
        done = true;
        return onRejected(ex);
      }
    };
  };

  module.exports = Promise;

}).call(this);
