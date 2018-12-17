#require 'app/models/user.rb'

describe User do
  context "when we test User" do

    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: "foobar", password_confirmation: "foobar")
    end

    it 'user should be valid' do
      expect(@user).to be_valid
    end

    it 'user.name should have validation' do
      @user.name = "   "
      expect(@user).to_not be_valid
    end

    it 'user.email should have validation' do
      @user.email = "   "
      expect(@user).to_not be_valid
    end

  end

end


