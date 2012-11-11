module HackerToDo
  class Setup
    CREDENTIAL_FILE = ".hacker_todo"
    attr_accessor :auth

    def initialize
      credential_file_location = File.join(Dir.home, CREDENTIAL_FILE)
      if File.exists?(credential_file_location)
        @auth = YAML.load(File.read(credential_file_location))
      else
        @auth = {
          :username => HackerToDo.get_from_console("Username:"), 
          :password => HackerToDo.get_from_console("Password:", true)
        }
        File.write(credential_file_location, @auth.to_yaml)
      end
    end
  end
end