module Versioner
  class Writer
    # version_parts : Array(String) = ["todo"]

    @target_match : Regex = /tbd/
    @target_match_as_string : String = "tbd"
    @from_file_name : String = "tbd"
    @to_file_name : String = "tbd"
    @from_version : String = "tbd"
    @to_version : String = "tbd"
    @to_version : String = "tbd"
    @segment_number_to_adjust : Int32 = 3

    def initialize
      set_target_match
      set_file_names
      # set_version(Versioner::Reader.new.version_per_shard)

      reader = Versioner::Reader.new
      puts "reader.version_per_shard:"
      puts reader.version_per_shard

      puts "----"
      puts /Version:/.to_s
      puts "----"
    end

    def set_target_match(@target_match = /Version:/, @target_match_as_string = "Version:") #  = "Version:")
    end

    def set_file_names(@from_file_name = "README.md", @to_file_name = "README.md.TOBE")
    end

    def set_version(@to_version = "0.0.1")
    end

    # def set_segment_number_to_adjust(@segment_number_to_adjust = 3)
      # TODO
    # end

    def write_readme_version # (@to_version = "0.0.1")
      if @from_file_name == @to_file_name
        puts "ERROR! attempting to write to same file"
      else
        File.open(@to_file_name, "w") do |to_file|
          File.open(@from_file_name, "r") do |from_file|
            to_file.print "Hello, "
            to_file.puts "Crystal!"
            to_file.puts "Appending more text:..."

            from_file.each_line do |from_line|
              if @target_match =~ from_line
              # if /#{from_line}/.match(@target_match)
                # to_file.puts(from_line)
                to_file.print(@target_match_as_string)
                to_file.print(" ")
                # if at line with match, then append updated version number:
                to_file.puts(@to_version)
              else
                to_file.puts(from_line)
              end
            end
          end
        end
      end
    end

    def run
      puts ":starting:"
      write_readme_version # (to_version)
      puts ":ending:"
    end
  end
end
