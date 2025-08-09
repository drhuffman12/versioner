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

    def update_readme
      update_writer = Versioner::Writer.new

      ver = @update_reader.version_per_shard # .split("\\.")
      parts = ver.split('.')
      parts[2] = (parts[2].to_i+1).to_s
      # puts "tobe parts:"
      # p! ver
      # p! parts
      update_writer.set_version(parts.join('.'))

      update_writer.run
      File.rename("README.md", "README.md.OLD")
      File.rename("README.md.TOBE", "README.md")
      # bump the version:
      # ... todo ... update_writer.run(@version_parts.to_s)
    end

    def update_shard
      update_writer = Versioner::Writer.new

      ver = @update_reader.version_per_shard # .split("\\.")
      parts = ver.split('.')
      parts[2] = (parts[2].to_i+1).to_s
      # puts "tobe parts:"
      # p! ver
      # p! parts

      update_writer.set_file_names("shard.yml","shard.yml.TOBE")
      update_writer.set_target_match(/^version:/, "version:")
      update_writer.set_version(parts.join('.'))

      update_writer.run
      File.rename("shard.yml", "shard.yml.OLD")
      File.rename("shard.yml.TOBE", "shard.yml")
      # bump the version:
      # ... todo ... update_writer.run(@version_parts.to_s)
    end

    def now_swap_updated_files
      # todo...
    end

    def run
      update_readme
      update_shard
    end
  end
end
