# `Versioner` is a basic utility to help keep a repo's version in sync and updated across various files
module Versioner
  module About
    VERSION = "0.0.3"
  end

  class Updater
    @matches : Array(Array(String))
    @count : Int32 = 0
    @version_parts : Array(String)
    @done : Bool = false

    def initialize
      @matches = Array(Array(String)).new
      @version_parts = Array(String).new
    end

    def scan_files(file_name : String) # , keyword_target : String = "version:")
      File.open(file_name, "r") do |file|
        puts
        puts "FFF"
        puts file.size
        puts "--------"
        file.each_line do |line|
          seek_matching_line(line) unless line.nil? || line.size == 0
        end
      end
    end

    def seek_matching_line(line, regex = /Version:/)
      # puts "INSIDE: seek_matching_line..." + [line, regex].to_s
      # pattern = /#{line}(regex)/
      
      # match_data = regex.match(line)

      if match_data = line.match(regex)
        line_after_match = match_data.post_match
        puts "*:) Match found!"
        if line_after_match
          # @version_parts += match_data
          # @version_parts << match_data[0]
          # puts "Matched line: #{match_data[0]}" # The entire matched string
          # puts "followed by line_after_match: [#{line_after_match}]" # The entire matched string
          # If your regex has capture groups, you can access them by index:
          # puts "First capture group: #{match_data[1]}"
          extract_version_nums(line_after_match, 0)
          # puts "version_parts: " + @version_parts.to_s
        end
      # else
      #   puts "0!( No match found."
      end
    end

    def extract_version_nums(text, i : Int32)
      # puts "INSIDE: extract_version_nums..." + [text, i].to_s
      # puts "text: " + text
      # puts "i: " + i.to_s
      @done = (i >= 3)

      if text
        # regex = /\d{0,3}([A-Za-z]{0,2})/
        regex = /\d/
        
        sub_match_data = text.match(regex)
        # puts i.to_s + " (sub_match_data) >" + sub_match_data.to_s

        if sub_match_data
          @version_parts << sub_match_data[0] # .to_s.to_i # 
          text_after_match = sub_match_data.post_match

          # puts i.to_s + " (sub_match_data) >" + sub_match_data.to_s
          # puts ">>>> @version_parts: " + @version_parts.to_s
          # puts ">>>> text_after_match: " + text_after_match.to_s

          # puts "V!" + @version_parts.to_s + "!V"
          # puts (" " * i * 2) + "*:) Match found!"
          # puts (" " * i * 2) + "sub-Matched text: #{sub_match_data[0]}" # The entire matched string
          # puts (" " * i * 2) + "sub-followed by text_after_match: #{text_after_match}" # The entire matched string
          # If your regex has capture groups, you can access them by index:
          # puts "First capture group: #{sub_match_data[1]}"

          extract_version_nums(text_after_match, i + 1) unless (@done || (i >= 3))
        # else
        #   puts "0!( No match found."
        end
      end

      # puts
      # puts "M" + @matches.to_s + "M"
      # file_name.close
    end

    def run
      puts ":starting:"
      scan_files(file_name = "README.md")
      puts "The repo Version, as per 'README.md' is: '" + @version_parts.join(".") + "'"
      puts "The shard version, as per 'shard.yml' is: '" + `shards version` + "'"
      puts "The source version, as per 'Versioner::About::VERSION' is: '" + Versioner::About::VERSION + "'"
      # read_file("README.md","version")
      puts ":ending:"
    end
  end

  # p Versioner::About::VERSION
  updated = Versioner::Updater.new
  updated.run
end
