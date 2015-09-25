
module Fedora2To3PidRenamer::Manipulator
  class Text < Base
    
    alias_method :text, :source
    
    def run
      config.changes.each do |before, after|
        change(text, before, after)
      end
    end
    
    def output
      text
    end
    
    
  end
end
