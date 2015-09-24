require_relative "../../test_helper"

module Fedora2To3PidRenamer
  class ManipulatorTest < Minitest::Test

    def test_run
      xpath = config.locations.first
      before, after = config.changes.first
      
      text_before = manipulator.xml.xpath(xpath, config.namespaces).text
      assert_match before, text_before
      refute_match after, text_before
      
      manipulator.run
      
      text_after = manipulator.xml.xpath(xpath, config.namespaces).text
      refute_match before, text_after
      assert_match after, text_after
    end

    def manipulator
      @manipulator ||= Manipulator.new(xml_raw, config)
    end

    def config
      @config ||= Config.load(config_file_path)
    end

    def xml_raw
      @xml_raw ||= file_read "cmodel-1.xml"
    end

  end
end
