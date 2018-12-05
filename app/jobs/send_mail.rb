class SendMail < ApplicationJob

  @queue = :mail_send

  def self.perform(user)
    @user = user
    UserMailer.account_activation(@user).deliver_now
    puts "-------------------------------done-------------------------------------"
  end

end