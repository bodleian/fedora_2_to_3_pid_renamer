require_relative '../test_helper'

class Fedora2To3PidRenamerTest < Minitest::Test

  def test_environment
    assert_equal true, true
  end

  def test_data_can_be_loaded
    lines = File.readlines(xml_file_path)
    expected = '<?xml version="1.0" encoding="UTF-8"?>'
    assert_equal expected, lines.first.strip
  end

  def test_xml_load
    file = File.read(xml_file_path)
    xml = Nokogiri::XML(file)
    assert_equal Nokogiri::XML::Document, xml_load(xml_file_name).class
    assert_equal xml.children.size, xml_load(xml_file_name).children.size
    assert_equal xml.to_s, xml_load(xml_file_name).to_s
  end

  def test_get_xml_attribute
    expected = 'changeme:CModel1'
    xml = xml_load(xml_file_name)
    namespaces = {'foxml' => 'info:fedora/fedora-system:def/foxml#'}
    node = xml.xpath('//foxml:digitalObject/@PID', namespaces)
    assert_equal expected, node.text
  end

  def test_get_xml_attribute_from_simple
    xml = xml_load('simple.xml')
    node = xml.xpath('//foo/@ID')
    assert_equal 'bar', node.text
  end

  def xml_file_path
    File.expand_path("../data/#{xml_file_name}", File.dirname(__FILE__))
  end

  def xml_file_name
    'cmodel-1.xml'
  end

end
