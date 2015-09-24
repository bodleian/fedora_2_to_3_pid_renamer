require 'nokogiri'
module Fedora2To3PidRenamer
  class Manipulator

    attr_accessor :raw_xml, :config

    def initialize(raw_xml, config)
      @raw_xml = raw_xml
      @config = config
    end

    def run
      config.locations.each do |location|

        node = xml.xpath(location, config.namespaces).first
        next unless node
        
        text = node.value
        config.changes.each do |before, after|
          text.gsub! before, after
        end

        node.value = text

      end
    end

    def xml
      @xml ||= Nokogiri::XML(raw_xml)
    end

  end
end
