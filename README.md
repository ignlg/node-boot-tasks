# boot-tasks

Simple nodejs boot tasks manager. Executes a list of tasks, sync or async. That's all.

[![NPM](https://nodei.co/npm/boot-tasks.png)](https://npmjs.org/package/boot-tasks)

## Installation
```
$ npm install boot-tasks
```

## Usage example in CoffeeScript:
```coffeescript
BootTasks = require 'boot-tasks'

# Set final callback
tasks = new BootTasks ->
  console.log " [*] Server %s listening on %s:%d"
    , server.nodename
    , argv.host
    , argv.port
  server.listen argv.port, argv.host

# Set sync mode
tasks.sync()

# Add a task: redis
tasks.task ->
  redisClient = redis.createClient config.redis.port
    , config.redis.host
    , config.redis.params

  redisClient.on 'ready', ->
    console.log " [ ] redisClient ready"
    tasks.done()

# Run tasks
tasks.do()
```

## Functions
### Constructor
```javascript
BootTasks = require 'boot-tasks'
tasks = new BootTasks(end)
```
Optional _end_ parameter as a function to call at the end.

### .sync() and .async()
Set the execution mode. Default: _sync_

### .on('done', callback) or .ondone(callback)
Function _callback_ to call at the end.

### .task(func)
Add a _func_ function as a task.

### .done()
Call at the end of every task to continue execution (only sync mode).

### .do(context)
Process all the tasks. Optional _context_ parameter for the tasks.

## To-Do
* Dependency management
* _done_ function as a parameter
* Emit events
* Tests