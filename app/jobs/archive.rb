class Archive

  @queue = :file_serve

  def self.perform(user_id, branch = 'master')
    user = User.find(user_id)
    user.async_create_archive(branch)
  end



end