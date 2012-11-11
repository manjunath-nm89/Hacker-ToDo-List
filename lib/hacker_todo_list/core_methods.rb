# Hacker ToDo Class Methods
module HackerToDo
  def self.get_from_console(console_string, hide_input = false)
    print "#{console_string} "
    system "stty -echo" if hide_input
    user_input = gets.chomp
    system "stty echo" if hide_input
    return user_input
  end

  def self.list_formatter
    puts ""
    puts "Hacker ToDo List:"
    yield
    puts ""
  end
end