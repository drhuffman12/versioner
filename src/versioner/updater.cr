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

    def update_readme(replace_old = true)
      update_writer = Versioner::Writer.new

      ver = @update_reader.version_per_shard # .split("\\.")
      parts = ver.split('.')
      parts[2] = (parts[2].to_i + 1).to_s
      update_writer.version(parts.join('.'))

      update_writer.run

      if replace_old
        File.rename("README.md", "README.md.OLD")
        File.rename("README.md.TOBE", "README.md")
      end
      # bump the version:
      # ... todo ... update_writer.run(@version_parts.to_s)
    end

    def update_shard(replace_old = true)
      update_writer = Versioner::Writer.new

      ver = @update_reader.version_per_shard # .split("\\.")
      parts = ver.split('.')
      parts[2] = (parts[2].to_i + 1).to_s

      update_writer.file_names("shard.yml", "shard.yml.TOBE")
      update_writer.target_match(/^version:/, "version:")
      update_writer.version(parts.join('.'))

      update_writer.run
      if replace_old
        File.rename("shard.yml", "shard.yml.OLD")
        File.rename("shard.yml.TOBE", "shard.yml")
      end
      # bump the version:
      # ... todo ... update_writer.run(@version_parts.to_s)
    end

    def auto_bump(replace_old = true)
      puts "WARNING: If you want to force updates, use 'Versioner::Updater.new.run(replace_old = false)'"
      Versioner::Updater.new.run(replace_old) #  = true
    end

    def run(replace_old = false)
      puts "WARNING: If you want to force updates, use 'Versioner::Updater.new.run(replace_old = true)'"
      update_readme(replace_old)
      update_shard(replace_old)
    end
  end
end
