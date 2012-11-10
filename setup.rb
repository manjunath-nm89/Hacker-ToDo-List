module HackerToDo

  def self.get_from_console(console_string, hide_input = false)
    print "#{console_string} "
    system "stty -echo" if hide_input
    user_input = gets.chomp
    system "stty echo" if hide_input
    return user_input
  end
  
  class Setup
    CREDENTIAL_FILE = ".hacker_todo"
    attr_accessor :auth

    def initialize
      if File.exist?(CREDENTIAL_FILE)
        @auth = YAML.load(File.read(CREDENTIAL_FILE))
      else
        @auth = {
          :username => HackerToDo.get_from_console("Username:"), 
          :password => HackerToDo.get_from_console("Password:", true)
        }
        File.write(CREDENTIAL_FILE, @auth.to_yaml)
      end
    end
  end
end