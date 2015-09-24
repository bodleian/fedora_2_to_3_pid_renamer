require 'minitest/autorun'
require 'nokogiri'
require_relative '../lib/fedora_2_to_3_pid_renamer'

class Minitest::Test
  def xml_load(file_name)
    file = file_read(file_name)
    Nokogiri::XML file
  end

  def data_file_path(file_name)
    File.expand_path("data/#{file_name}", File.dirname(__FILE__))
  end

  def file_read(file_name)
    File.read data_file_path(file_name)
  end
  
  def config
    @config ||= Fedora2To3PidRenamer::Config.new(config_source)
  end

  def config_source
    @config_source ||= File.read config_file_path
  end
  
  def config_file_path
    data_file_path 'config.yml'
  end
end
