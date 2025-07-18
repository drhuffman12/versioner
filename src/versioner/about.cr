# `Versioner` is a basic utility to help keep a repo's version in sync and updated across various files
module Versioner
  module About
    VERSION = "0.0.1a"
  end

  class Updater
    def read_file(file_name : String, keyword_target : String = "version")
      file = File.new(file_name, "r")
      count = 0
      matches = Array(Array(String)).new
      keyword_matches = Array(String).new
      version = Array(String).new

      file_name.each_line() do |row|
        recored = row.split
        if record[0].compare(keyword_target, case_insensitive: true) == 0
          keyword_matches << record[0]
          version << record[1] unless record[1].nil?
          # version << record[2] if record[1].nil? && !record[2].nil?
          matches << [keyword_matches.first, version.first]
          count += 1
        end
      end

      puts matches
      file_name.close
    end

    def run
      read_file("README.md","version")
    end
  end
  # p Versioner::About::VERSION
  updated = Versioner::Updater.new
  updated.run
end
