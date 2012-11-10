require File.dirname(__FILE__) + "/setup"
require "debugger"
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

    def list
      if @todo_id.nil?
        puts "You need to create a todo first"
      else
        get_todo_content(@todo_gist).each_with_index do |task, index|
          puts "#{index + 1}. #{task}"
        end
      end
    end

    def add(task_list)
      content = task_list.split("\\n")
      route = @todo_id.nil? ? "/gists" : "/gists/#{@todo_id}"
      post_gist(route, append_todo_content(content))
    end

    def delete(index)
      task_index = index.to_i - 1
      todo_array = get_todo_content(@todo_gist)
      todo_array.delete_at(task_index) 
      post_gist("/gists/#{@todo_id}", todo_array)
    end

    def find_todo_entry
      todo_entry = self.class.get("/users/#{@github_creds[:username]}/gists", 
        {:basic_auth => @github_creds}).find do |gist|
          gist["files"].has_key?(GIST_FILE_NAME) && gist["description"] == GIST_DESCRIPTION
      end
      self.class.get("/gists/#{todo_entry["id"]}", {:basic_auth => @github_creds}) if todo_entry
    end

    private

    def post_gist(route, content)
      @todo_gist = self.class.post(route, {:body => create_gist_json(content), :basic_auth => @github_creds})
      @todo_id = @todo_gist["id"]
    end

    def append_todo_content(content)
      @todo_gist.nil? ? content : get_todo_content(@todo_gist) + content
    end

    def get_todo_content(gist_object)
      YAML.load(gist_object["files"][GIST_FILE_NAME]["content"])
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

@todo_list = HackerToDo::ToDoList.new
method = ARGV.any? ? ARGV : ["list"]
@todo_list.send(*method)