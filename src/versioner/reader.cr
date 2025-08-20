module Versioner
  class Reader
    @version_parts : Array(String)

    @from_file_name : String = "todo"

    @matches : Array(Array(String))
    @count : Int32 = 0
    @done : Bool = false

    def initialize
      @matches = Array(Array(String)).new
      @version_parts = Array(String).new
    end

    def version_parts
      @version_parts
    end

    def update_from_file_name(from_file_name = "README.md")
      @from_file_name = from_file_name
    end

    def scan_files
      File.open(@from_file_name, "r") do |file|
        file.each_line do |line|
          seek_matching_line(line) unless line.nil? || line.size == 0
        end
      end
    end

    def seek_matching_line(line, regex = /^Version:/)
      if match_data = line.match(regex)
        line_after_match = match_data.post_match
        # puts "*:) Match found!"
        if line_after_match
          extract_version_nums(line_after_match, 0)
        end
      end
    end

    def extract_version_nums(text, i : Int32)
      if text
        # regex = /\d*/
        regex = /\d+/
        sub_match_data = text.match(regex)

        if sub_match_data
          @version_parts << sub_match_data[0] # .to_s.to_i #
          text_after_match = sub_match_data.post_match

          # puts i.to_s + " (sub_match_data) >" + sub_match_data.to_s
          # puts ">>>> version_parts: " + @version_parts.to_s
          # puts ">>>> text_after_match: " + text_after_match.to_s

          extract_version_nums(text_after_match, i + 1) unless text_after_match.empty? || i > 4
        else
          puts "NON MATCH!:"
          puts "text:" + text
          puts "i:" + i.to_s
          puts "sub_match_data:" + sub_match_data.to_s
          raise "Oops"
        end
      end
    end

    def write_readme_version
      puts "-starting-"
      scan_files
      # puts "The repo Version, according to README.md is: " + @version_parts
      # puts "The shard version, according to shard.yml is: " + (`shards version`.strip)

      they_match = (@version_parts.join('.') == (`shards version`.strip))
      if they_match
        puts "They match"
      else
        puts "They DO NOT match"
      end
    end

    def echo_version
      puts "-starting-"
      scan_files
      # puts "The repo Version, according to README.md is: " + @version_parts.join('.')
      # puts "The shard version, according to shard.yml is: " + (`shards version`.strip)

      they_match = (@version_parts.join('.') == (`shards version`.strip))
      if they_match
        puts "They match "
      else
        puts "They DO NOT match"
      end
      puts "-ending-"
    end

    def does_it_match
      if ((@version_parts.join('.') == (`shards version`.strip).to_s)).to_s
        puts "They match "
      end
      (@version_parts.join('.') == (`shards version`.strip))
    end

    def version_parts_goto(to_version_parts : Array(String) = "0.0.1".split('.'))
      @version_parts = to_version_parts
    end

    def version_parts_after
      @version_parts.join(".")
    end

    def version_per_readme
      run
      @version_parts.join(".")
    end

    def version_per_shard
      (`shards version`.strip)
    end

    def run(from_file_path : String = "README.md") : Array(String)
      update_from_file_name(from_file_path)
      scan_files # (from_file_path)
      # puts "The repo Version, as per '" + from_file_path + "' is: '" + @version_parts.join(".") + "'"
      # puts "The shard version, as per 'shard.yml' is: '" + (`shards version`.strip) + "'"

      they_match = (@version_parts.join(".") == (`shards version`.strip))
      
      @version_parts
    end
  end
end
