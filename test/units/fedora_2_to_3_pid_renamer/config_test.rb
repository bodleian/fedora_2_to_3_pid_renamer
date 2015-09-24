require_relative '../../test_helper'

module Fedora2To3PidRenamer
  class ConfigTest < Minitest::Test

    def test_namespaces
      assert_equal config_yml['namespaces'], config.namespaces
    end

    def test_locations
      assert_equal config_yml['locations'], config.locations
    end

    def test_changes
      assert_equal config_yml['changes'], config.changes
    end

    def test_change_for
      changes = config_yml['changes']
      changes.each do |original, becomes|
        assert_equal becomes, config.change_for(original), "#{original} should become #{becomes}"
      end
    end

    def test_changeme_replacement
      assert_equal config_yml['changeme'], config.changeme_replacement
    end

    def test_load
      config = Config.load(config_file_path)
      assert_equal config_yml['changes'], config.changes
    end
    
    def test_input_folder
      assert_match File.join('test', 'data', 'input'), config.input_folder 
    end
    
    def test_input_folder
      assert_match File.join('test', 'data', 'output'), config.output_folder 
    end

    private
    def config
      @config ||= Config.new(config_source)
    end

    def config_source
      @config_source ||= File.read config_file_path
    end

    def config_yml
      @config_yml ||= YAML.load(config_source)
    end

  end
end
