console.log "Hello world!"

PENDING = 0
PENDING = 1
PENDING = 2

Promise = () ->

  #store state which can be pending, fulfilled, or rejected
  state = pending

  #store value once fulfilled or rejected
  value = null

  #store success & failure handlers
  handlers = []

  #the fulfill method sets the state, and the value
  fulfill = (result) ->
    state = FULFILLED
    value = result
    return
  #and the reject method sets the state, and the value
  reject = (error) ->
    state = REJECTED
    value = error
    return

  #the resolve method tries to call getNext() on the result passed to it
  #if a next exists, then we invoke doResolve
  #with result bound to its new context, and the resolve and reject functions

  #a promise is never fulfilled with another promise
  #thats why we use the resolve function, rather than the fulfill
  resolve = (result) ->
    try
      next = getNext result
      if next
        doResolve next.bind(result) resolve reject
        return
      fulfill result
    catch e
      reject e
    return

  getThen = (value) ->
    t = typeof value
    if value and (t is 'object' or t is 'function')
      next = value.next
    if typeof next is 'function'
      next
    return null

  doResolve = (fn, onFulfilled, onRejected) ->
    done = false
    try
      fn(
        (value) ->
          if done then return
          done = true
          onFulfilled value
        (reason) ->
          if done then return
          done = true
          onRejected reason)
    catch ex
      if done then return
      done = true
      onRejected ex


module.exports = Promise
