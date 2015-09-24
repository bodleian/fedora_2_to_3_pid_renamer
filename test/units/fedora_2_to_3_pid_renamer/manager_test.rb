require_relative '../../test_helper'
require 'fileutils'

module Fedora2To3PidRenamer
  class ManagerTest < Minitest::Test
    
    def setup
      FileUtils.mkdir data_file_path('input')
      FileUtils.mkdir data_file_path('output')
      target_files.each do |file|
        destination = File.join 'input', file
        FileUtils.cp data_file_path(file), data_file_path(destination)
      end
    end

    def teardown
      FileUtils.remove_dir data_file_path('input'), true
      FileUtils.remove_dir data_file_path('output'), true
    end
    
    def test_before
      output_files = Dir.glob(data_file_path 'output/*.xml')
      assert output_files.empty?, "There should be no files in output: #{output_files}"
    end
    
    def test_create_output_folder
      assert_equal false, manager.create_output_folder
      assert_equal true, Dir.exist?(config.output_folder)
    end
    
    def test_create_output_folder_when_none_exists
      FileUtils.remove_dir data_file_path('output'), true
      assert manager.create_output_folder, 'Should return truthy if folder created'
      assert_equal true, Dir.exist?(config.output_folder)
    end
    
    def test_run_manipulation
      manager.run_manipulation
      target_files.each do |file|
        output_file = data_file_path(File.join('output', file))
        assert File.exist?(output_file), "#{output_file} should exist"
      end
    end
    
    def test_run_manipulation_alters_content
      manager.run_manipulation
      xml = xml_load File.join('output', target_files.first)
      xpath = config.locations.first
      text = xml.xpath(xpath).text
      assert_match config.changeme_replacement, text
    end   
    
    def manager
      @manager ||= Manager.new(config)
    end
    
    def target_files
      [
        'cmodel-1.xml', 
        'cmodel-1.deployment1.xml'
      ]
    end

  end
end
