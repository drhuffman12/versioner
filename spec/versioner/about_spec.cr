require "../spec_helper"
# require "../../src/versioner/about"

describe Versioner do
  it "version in shard.yml matches version in Versioner::About::VERSION" do
    (`shards version .`).strip.should eq(Versioner::About::VERSION)
  end
end

