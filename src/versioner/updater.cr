# `Versioner` is a basic utility to help keep a repo's version in sync and updated across various files

require "../../src/versioner/reader"
require "../../src/versioner/writer"

module Versioner
  class Updater
    @version_parts : Array(String) = ["todo"]

    def initialize
      @update_reader = Versioner::Reader.new
      @version_parts = @update_reader.run("README.md")
    end

    def run
      update_writer = Versioner::Writer.new

      ver = @update_reader.version_per_shard # .split("\\.")
      parts = ver.split('.')
      parts[2] = (parts[2].to_i+1).to_s
      # puts "tobe parts:"
      # p! ver
      # p! parts
      update_writer.set_version(parts.join('.'))

      update_writer.run
      # bump the version:
      # ... todo ... update_writer.run(@version_parts.to_s)
    end
  end
end
