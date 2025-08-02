# `Versioner` is a basic utility to help keep a repo's version in sync and updated across various files

# require "../src/versioner/about.cr"
require "../src/versioner/reader.cr"

module Versioner
  # p Versioner::About::VERSION
  Versioner::Reader.new.run
end
