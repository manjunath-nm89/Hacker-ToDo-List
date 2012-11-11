#!/usr/bin/env ruby
require "hacker_todo_list"

todo_list = HackerToDo::ToDoList.new
method = ARGV.empty? ? "list" : ARGV
todo_list.send(*method)