require "../../spec/spec_helper"
require "../../src/versioner/reader"
require "../../src/versioner/writer"
require "../../src/versioner/updater"

describe Versioner do
  # it "version in shard.yml matches version in Versioner::About::VERSION" do
  #   (`shards version .`).strip.should eq(Versioner::About::VERSION)
  # end

  it "parses the README" do
    reader = Versioner::Reader.new
    reader.run
    (reader.does_it_match).should be_true
  end

  it "resets the version variable" do
    reader = Versioner::Reader.new
    (reader.version_parts_goto(["1","2","3"])).should eq(["1","2","3"])
    (reader.version_parts_after).should eq("1.2.3")
  end

  it "the version (read) variable matches version_per_shard" do
    reader = Versioner::Reader.new
    # (reader.version_parts_after).should eq(reader.version_per_shard)
    (reader.run.join(".")).should eq(reader.version_per_shard)
  end

  it "the version (writen) matches version (read)" do
    reader = Versioner::Reader.new
    reader.run
    # version_written_already = reader.run #.join(".")
    # (version_written_already.join(".")).should eq(reader.version_per_shard)

    version_to_be = reader.version_per_shard
    # version_to_be = "1.2.4"
    print ">!!> version_to_be: " + version_to_be

    writer = Versioner::Writer.new
    writer.set_version(version_to_be)
    writer.run # (version_to_be)
    (reader.version_parts_after).should eq(reader.version_per_shard)
  end

  it "the version (writen) matches version (read)" do
    updated = Versioner::Updater.new
    updated.run
    
    # swap files....
  end
end

