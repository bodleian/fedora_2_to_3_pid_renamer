# The Config object is used to read a config file and pass around the settings
# defined in that file.
# See the README.md and test/data/config.xml for sample config.yml files.
require 'yaml'
module Fedora2To3PidRenamer
  class Config

    attr_reader :source

    def self.load(path)
      new File.read(path)
    end

    def initialize(source)
      @source = source
    end

    def namespaces
      @namespaces ||= yaml['namespaces']
    end

    def locations
      @locations ||= yaml['locations']
    end

    def changes
      @changes ||= yaml['changes']
    end
    
    def folders
      yaml['folders']
    end

    def change_for(original)
      changes[original]
    end

    def changeme_replacement
      yaml['changeme']
    end
    
    def input_folder
      return unless folders
      @input_folder ||= path_relative_to_working_directory folders['input']
    end
    
    def output_folder
      return unless folders
      @output_folder ||= path_relative_to_working_directory folders['output']
    end

    def yaml
      @yaml ||= YAML.load(source)
    end
    
    def path_relative_to_working_directory(folder)
      File.expand_path folder, Dir.pwd
    end

  end
end
