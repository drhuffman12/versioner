module Versioner
  class Writer
    @target_match : Regex = /tbd/
    @target_match_as_string : String = "tbd"
    @from_file_name : String = "tbd"
    @to_file_name : String = "tbd"
    @from_version : String = "tbd"
    @to_version : String = "tbd"
    @to_version : String = "tbd"
    @segment_number_to_adjust : Int32 = 3

    def initialize
      target_match
      file_names
      # version(Versioner::Reader.new.version_per_shard)

      reader = Versioner::Reader.new
      # puts "reader.version_per_shard:"
      # puts reader.version_per_shard

      # puts "----"
      # puts /Version:/.to_s
      # puts "----"
    end

    def target_match(@target_match = /Version:/, @target_match_as_string = "Version:") #  = "Version:")
    end

    def file_names(@from_file_name = "README.md", @to_file_name = "README.md.TOBE")
    end

    def version(@to_version = "0.0.1")
    end

    def write_readme_version # (@to_version = "0.0.1")
      if @from_file_name == @to_file_name
        puts "ERROR! attempting to write to same file"
      else
        File.open(@to_file_name, "w") do |to_file|
          File.open(@from_file_name, "r") do |from_file|
            from_file.each_line do |from_line|
              if @target_match =~ from_line
                to_file.print(@target_match_as_string)
                to_file.print(" ")
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
      write_readme_version # (to_version)
    end
  end
end
