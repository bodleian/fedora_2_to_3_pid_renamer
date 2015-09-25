
module Fedora2To3PidRenamer
  class TextManipulator
    
    attr_reader :text, :config
    
    def self.output_for(text, config)
      manipulator = new(text, config)
      manipulator.run
      manipulator.output
    end
    
    def initialize(text, config)
      @text = text
      @config = config
    end
    
    def run
      config.changes.each do |before, after|
        change(text, before, after)
      end
    end
    
    def output
      text
    end
    
    def change(text, before, after)
      pattern = Regexp.new("changeme:#{before}(#{end_of_string_or_non_word})")
      
      replacement = [
        config.changeme_replacement,
        after
      ].join(':') + first_capture_group
      
      text.gsub! pattern, replacement
    end
    
    def end_of_string_or_non_word 
      '[$\W]'
    end
    
    def first_capture_group
      '\1'
    end
    
  end
end
