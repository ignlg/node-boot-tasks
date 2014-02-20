# Simple nodejs boot tasks manager

class Tasker
  constructor: (@_end = ->) ->

  tasks: []
  todo: 0
  _doSync: true

  sync: ->
    @_doSync = true

  async: ->
    @_doSync = false

  on: (done, func) ->
    @_end = func if done is 'done'

  ondone: (@_end) ->

  task: (cb) ->
    if cb
      @tasks.push cb

  add: @task

  do: (@context) ->
    @todo = @tasks.length
    if not @_doSync
      @tasks.shift().apply @context, [] while @tasks.length
    else
      @tasks.shift().apply @context, []

  done: ->
    if not --@todo
      @_end.apply null, []
    else if @_doSync
      @tasks.shift().apply @context, []

module.exports = Tasker