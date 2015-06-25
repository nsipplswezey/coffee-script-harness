console.log "Hello world!"

PENDING = 0
FULFILLED = 1
REJECTED = 2


Promise = () ->

  #store state which can be pending, fulfilled, or rejected
  state = PENDING

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
  #so getNext might return undefined, if the result doesn't have a next
  #if it does, we fulfill it becase its a non-promise result
  #otherwise we doResolve on the next bound promise
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

  @done = (onFulfilled, onRejected) ->
    #ensure async
    setTimeout () ->
      handle
        onFulfilled : onFulfilled
        onRejected : onRejected
       return
      ,0
    return

  doResolve fn, resolve, reject
  return


doResolve = (fn, onFulfilled, onRejected) ->
  done = false
  try
    fn(
      (value) ->
        if done then return
        done = true
        onFulfilled value
        return
      (reason) ->
        if done then return
        done = true
        onRejected reason
        return)
  catch ex
    if done then return
    done = true
  onRejected ex

getThen = (value) ->
  t = typeof value
  if value and (t is 'object' or t is 'function')
    next = value.next
  if typeof next is 'function'
    next
  return null

  #helpers
  #getNext... returns a promise/thenable from result
  #doResolve... takes a context bound promise, a resolve and a reject
  #fulfill...


module.exports = Promise
