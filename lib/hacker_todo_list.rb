require File.dirname(__FILE__) + "/hacker_todo_list/core_methods.rb"
require File.dirname(__FILE__) + "/hacker_todo_list/extensions"
require File.dirname(__FILE__) + "/hacker_todo_list/setup"
require "httparty"
require "yaml"
require "json"

module HackerToDo
  GIST_FILE_NAME = "hacker_todo"
  GIST_DESCRIPTION = "Hacker To Do"

  class ToDoList
    include HTTParty
    base_uri "https://api.github.com"
    attr_accessor :github_creds, :todo_id

    def initialize
      @github_creds = Setup.new.auth
      @todo_gist = find_todo_entry
      @todo_id = @todo_gist.nil? ? nil : @todo_gist["id"]
    end

    def get_todo_content
      YAML.load(@todo_gist["files"][GIST_FILE_NAME]["content"])
    end

    def list
      content = get_todo_content
      if @todo_id.nil? || content.empty?
        puts "You need to create a ToDo"
      else
        HackerToDo.list_formatter do
          content.each_with_index do |task, index|
            puts "#{index + 1}. #{task}"
          end
        end  
      end
    end

    def add(task_list)
      content = task_list.split("\\n")
      route = @todo_id.nil? ? "/gists" : "/gists/#{@todo_id}"
      post_gist(route, append_todo_content(content))
      puts "ToDo added successfully."
      list
    end

    def delete(*indexes)
      post_gist("/gists/#{@todo_id}", get_todo_content.delete_indexes(indexes.collect{|index| index.to_i - 1}))
      puts "ToDo deleted successfully."
      list
    end

    def find_todo_entry
      todo_entry = self.class.get("/users/#{@github_creds[:username]}/gists", 
        {:basic_auth => @github_creds}).find do |gist|
          unless gist.is_a?(Array)
            gist["files"].has_key?(GIST_FILE_NAME) && gist["description"] == GIST_DESCRIPTION
          end
      end
      if todo_entry
        return self.class.get("/gists/#{todo_entry["id"]}", {:basic_auth => @github_creds}) 
      else
        puts "Your github credentials are incorrect"
        credential_file = File.join(Dir.home, HackerToDo::Setup::CREDENTIAL_FILE)
        system "rm -f #{credential_file}"
        return nil
      end
    end

    private

    def post_gist(route, content)
      @todo_gist = self.class.post(route, {:body => create_gist_json(content), :basic_auth => @github_creds})
      @todo_id = @todo_gist["id"]
    end

    def append_todo_content(content)
      @todo_gist.nil? ? content : get_todo_content + content
    end

    def create_gist_json(content)
      {
        :description => GIST_DESCRIPTION,
        :public => false, 
        :files => {
          GIST_FILE_NAME.to_sym => {
            :content => content.to_yaml
          }
        }
      }.to_json
    end
  end
end