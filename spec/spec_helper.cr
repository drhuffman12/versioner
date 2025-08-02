require "spec"

def puts_debug(message = "ENV DEBUG enabled!")
  puts message if ENV.has_key?("DEBUG") && ENV["DEBUG"] == "1"
end
