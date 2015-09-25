# Manager manages the process of modify a group of XML file as defined via
# a config object
module Fedora2To3PidRenamer
  class Manager
    
    attr_accessor :config
    
    def initialize(config)
      @config = config
    end
    
    def create_output_folder
      return false if Dir.exist?(config.output_folder)
      FileUtils.mkdir config.output_folder
    end
    
    def run_manipulation
      create_output_folder
      Dir.glob(input_file_pattern).each do |input_file|
        file_name = File.basename input_file
        manipulator = manipulator_for(file_name)
        next unless manipulator
        
        input = File.read input_file        
        output_file = File.join config.output_folder, file_name
        
        File.write output_file, manipulator.output_for(input, config)
      end
    end
    
    def input_file_pattern
      File.join config.input_folder, '*'
    end
    
    def manipulator_for(file_name)
      case file_name
      when /\.xml$/
        Manipulator::Xml
      when /cmodel-\d+\.deployments.txt/
        Manipulator::Text
      else
        nil
      end
    end
  end
end
