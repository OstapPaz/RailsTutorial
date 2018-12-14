#require 'app/models/user.rb'

describe User do
  context "when we test User" do

    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: "foobar", password_confirmation: "foobar")
    end

    it 'user should be valid' do
      @user.valid?.should == true
    end



  end
end