require "debugger"
require "httparty"
require "yaml"
require "json"

module HackerToDo
  CredentialFile = ".hacker_to_do"
  class Setup
    attr_accessor :auth
    
    def initialize
      if File.exist?(CredentialFile)
        @auth = YAML.load(File.read(CredentialFile))
      end
    end
  end
end
