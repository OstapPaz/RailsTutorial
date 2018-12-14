class HelloWorldSpec

  def say_hello
    "Hello world!"
  end

end

  describe HelloWorldSpec do
    context "When testing the HelloWorldSpec class" do

  it "should say 'HelloWorldSpec' when we call the say_hello method" do
    hw = HelloWorldSpec.new
    message = hw.say_hello
    expect(message).to eq "Hello world!"
  end

  puts "helloworld passed"

    end
  end