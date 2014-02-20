# Simple nodejs boot tasks manager

class Tasker
  constructor: (@end) ->

  tasks: []
  todo: 0
  _doSync: false

  sync: ->
    @_doSync = true

  async: ->
    @_doSync = false

  on: (done, func) ->
    @end = func if done is 'done'

  ondone: (@end) ->

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
      @end.apply null, []
    else if @_doSync
      @tasks.shift().apply @context, []

module.exports = Tasker