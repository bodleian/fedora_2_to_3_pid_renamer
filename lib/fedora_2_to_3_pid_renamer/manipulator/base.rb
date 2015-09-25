

module Fedora2To3PidRenamer::Manipulator
  class Base
    attr_reader :source, :config
    
    def self.output_for(*args)
      manipulator = new(*args)
      manipulator.run
      manipulator.output
    end
    
    def initialize(source, config)
      @source = source
      @config = config
    end
    
    def run
      raise 'run must be defined in sub-classes'
    end
    
    def output
      raise 'output must be defined in sub-classes'
    end
    
    private
    def change(text, before, after)
      pattern = Regexp.new("changeme:#{before}(#{end_of_string_or_non_word})")
      
      replacement = [
        config.changeme_replacement,
        after
      ].join(':') + first_capture_group
      
      text.gsub! pattern, replacement
    end
    
    def end_of_string_or_non_word 
      '$|\W'
    end
    
    def first_capture_group
      '\1'
    end
  end
end
