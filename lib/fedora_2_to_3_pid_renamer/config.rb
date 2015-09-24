require "yaml"
module Fedora2To3PidRenamer
  class Config

    attr_reader :source

    def self.load(path)
      new File.read(path)
    end

    def initialize(source)
      @source = source
    end

    def namespaces
      @namespaces ||= yaml["namespaces"]
    end

    def locations
      @locations ||= yaml["locations"]
    end

    def changes
      @changes ||= yaml["changes"]
    end

    def change_for(original)
      changes[original]
    end

    def changeme_replacement
      yaml["changeme"]
    end

    def yaml
      @yaml ||= YAML.load(source)
    end

  end
end
