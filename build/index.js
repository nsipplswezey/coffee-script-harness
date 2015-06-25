(function() {
  var FULFILLED, PENDING, Promise, REJECTED, doResolve, getThen;

  console.log("Hello world!");

  PENDING = 0;

  FULFILLED = 1;

  REJECTED = 2;

  Promise = function() {
    var fulfill, handlers, reject, resolve, state, value;
    state = PENDING;
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
    this.done = function(onFulfilled, onRejected) {
      setTimeout(function() {
        handle({
          onFulfilled: onFulfilled,
          onRejected: onRejected
        });
      }, 0);
    };
    doResolve(fun, resolve, reject);
  };

  doResolve = function(fun, onFulfilled, onRejected) {
    var done, ex;
    done = false;
    try {
      fun(function(value) {
        if (done) {
          return;
        }
        done = true;
        onFulfilled(value);
      }, function(reason) {
        if (done) {
          return;
        }
        done = true;
        onRejected(reason);
      });
    } catch (_error) {
      ex = _error;
      if (done) {
        return;
      }
      done = true;
    }
    return onRejected(ex);
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

  module.exports = Promise;

}).call(this);
