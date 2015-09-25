require_relative '../../test_helper'

module Fedora2To3PidRenamer
  class TextManipulatorTest < Minitest::Test

    def test_run
      before = 'changeme:CModel1-SDep1'
      after = [
        config.changeme_replacement,
        config.change_for('CModel1-SDep1')
      ].join(':')
      
      
      assert_match before, text_manipulator.text
      refute_match after, text_manipulator.text
      
      text_manipulator.run
      
      refute_match before, text_manipulator.text
      assert_match after, text_manipulator.text
    end
    
    def test_text
      assert_equal file_text, text_manipulator.text
    end
    
    private
    def text_manipulator
      @text_manipulator ||= TextManipulator.new(file_text, config)
    end
    
    def file_text
      @file_text ||= file_read 'cmodel-1.deployments.txt'
    end
    
  end
end
