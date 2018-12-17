require "rspec/expectations"

describe "before and after callbacks" do
  before(:all) do
    puts "before all"
  end

  before do
    puts "before simple"
  end

  after do
    puts "after simple"
  end

  after(:all) do
    puts "after all"
  end

  it "gets run in first" do
    puts "it-1"
  end

  it "gets run in second" do
    puts "it-2"
  end

end