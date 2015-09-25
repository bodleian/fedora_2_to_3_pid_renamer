require_relative '../../../test_helper'

module Fedora2To3PidRenamer::Manipulator
  class XmlTest < Minitest::Test

    def test_run
      before, after = config.changes.first      
      assert_at_xpath_text_changes(before, after) { xml_manipulator.run }
    end
    
    def test_run_modifies_changeme_namespace
      before = 'changeme:'
      after = config.changeme_replacement + ':'      
      assert_at_xpath_text_changes(before, after) { xml_manipulator.run }
    end
    
    def test_output
      assert_equal Nokogiri::XML(xml_raw).to_s, xml_manipulator.output
    end
    
    def test_run_alters_output
      xml_manipulator.run
      refute_equal Nokogiri::XML(xml_raw).to_s, xml_manipulator.output
    end
    
    def test_run_produces_well_formed_xml
      xml_manipulator.run
      doc = Nokogiri::XML xml_manipulator.output
      assert doc.errors.empty?, "Nokogiri should not find errors: #{doc.errors}"
    end
    
    def test_output_for
      xml_manipulator.run
      assert_equal xml_manipulator.output, Xml.output_for(xml_raw, config)
    end
    
    private
    def assert_at_xpath_text_changes(before, after)
      xpath = config.locations.first
      
      text_before = xml_manipulator.xml.xpath(xpath, config.namespaces).text
      assert_match before, text_before
      refute_match after, text_before
      
      yield
      
      text_after = xml_manipulator.xml.xpath(xpath, config.namespaces).text
      refute_match before, text_after
      assert_match after, text_after
    end
    

    def xml_manipulator
      @xml_manipulator ||= Xml.new(xml_raw, config)
    end

    def xml_raw
      @xml_raw ||= file_read 'cmodel-1.xml'
    end

  end
end
