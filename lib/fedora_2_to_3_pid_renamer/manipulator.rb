require 'nokogiri'
module Fedora2To3PidRenamer
  class Manipulator

    attr_accessor :raw_xml, :config
    
    def self.output_for(raw_xml, config)
      manipulator = new(raw_xml, config)
      manipulator.run
      manipulator.output
    end

    def initialize(raw_xml, config)
      @raw_xml = raw_xml
      @config = config
    end

    def run
      modify_text_at_each_location_in_config
    end

    def xml
      @xml ||= Nokogiri::XML(raw_xml)
    end
    
    def output
      xml.to_s
    end
    
    private
    def modify_text_at_each_location_in_config
      config.locations.each do |location|

        node = xml.xpath(location, config.namespaces).first
        next unless node
        
        text = node.value
        config.changes.each do |before, after|
          text.gsub! before, after
        end

        text.gsub! 'changeme:', (config.changeme_replacement + ':')
        
        node.value = text

      end
    end

  end
end
