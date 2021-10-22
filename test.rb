require "sqlite3"
require_relative "task"

DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true

## CRUD

# CREATE

task = Task.new(title: 'Partir en vacances', description: 'dans 25 min')
task.save

# READ

task = Task.find(2)
puts "#{task.done ? '[X]' : '[ ]'} - #{task.title} : #{task.description}"

p Task.all

# UPDATE

task = Task.find(2)
task.done!
task.save

task = Task.find(2)
puts "#{task.done ? '[X]' : '[ ]'} - #{task.title} : #{task.description}"

# DELETE
p Task.all.size

task = Task.find(1)
task.delete

p Task.all.size

