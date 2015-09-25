# Manipulator is the tool used to modify the XML files passed to it based on
# the settings defined in the config.
require 'nokogiri'
module Fedora2To3PidRenamer::Manipulator
  class Xml < Base

    alias_method :raw_xml, :source

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
          change(text, before, after)
        end       
        node.value = text

      end
    end

  end
end
