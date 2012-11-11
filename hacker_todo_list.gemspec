Gem::Specification.new do |s|
  s.name        = 'hacker_todo_list'
  s.version     = '1.0.2'
  s.date        = '2012-11-11'
  s.summary     = "A command line To-Do list"
  s.description = %Q{
    Hacker ToDo List is integrated with github and all your todo's are stored as private gists. 
    So, you need not worry about your to-do's when you switch from your office machine to your home machine. 
    Just provide your github credentials, your todo's will be synced.
  }  
  s.authors     = ["Manjunath"]
  s.email       = 'manjunath.nm89@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.homepage    = 'https://github.com/manjunath-nm89/Hacker-ToDo-List'
  s.add_dependency "httparty", ">= 0.9.0"
  s.add_dependency "json", ">= 1.7.5"
end