Hacker ToDo List
================

Hacker ToDo List is a command line to-do list,  primarily for hackers who do not like to take their hands off the keyboard. [Hacker ToDO List](https://rubygems.org/gems/hacker_todo_list) is available as a [gem](https://rubygems.org/gems/hacker_todo_list)

Features
--------

Hacker ToDo List is integrated with github and all your todo's are stored as private gists. So, you need not worry about your to-do's when you switch from your office machine to your home machine. Just provide your github credentials, your todo's will be synced.

Installation
------------

    gem install hacker_todo_list

Usage
-----

    > require "hacker_todo_list"
 
    > todo_list = HackerToDo::ToDoList.new

    Username: manjunath-nm89
    Password:

    > todo_list.add "Create a ruby gem \nUpdate the version \nLearn to play Guitar"

    ToDo added successfully.

    Hacker ToDo List:
    1. Create a ruby gem 
    2. Update the version
    3. Learn to play Guitar

    > todo_list.delete 1 2

    ToDo deleted successfully.    

    Hacker ToDo List:
    1. Learn to play Guitar

    > todo_list.list

    Hacker ToDo List:
    1. Learn to play Guitar

ToDo Application
-----------

I have setup a client which uses the [Hacker ToDO List](https://rubygems.org/gems/hacker_todo_list) gem.
Check it out, this file can be made as an executable and used as a ToDo application.
    
    > gem install "hacker_todo_list"
    > echo "alias hacker_todo='ruby path/to/hacker_todo_list_client.rb'" >> ~/.bashrc
    > source ~/.bashrc (or open a new terminal)

Now from anywhere, you can do,
   
    > hacker_todo add "Go to the grocery store"
    > hacker_todo delete 1
    > hacker_todo