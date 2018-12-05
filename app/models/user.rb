class User < ApplicationRecord



  has_many :microposts, dependent: :destroy




  has_many :active_relationships, class_name: "Relationship",
                                              foreign_key: "follower_id",
                                              dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed




  has_many :passive_relationships, class_name:  "Relationship",
           foreign_key: "followed_id",
           dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower





  attr_accessor :remember_token, :activation_token, :reset_token


  before_save { self.email = self.email.downcase }
  before_create :create_activation_digest


  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  #after_create :async_create_archive, on: :create

  after_create :async_send_activation_mail, on: :create


  def async_send_activation_mail
    #Resque.enqueue(SendMail, self)
    SendMail.perform(self)
    #UserMailer.account_activation(self).deliver_now
    puts "send activation email checker _------------------------------------------------------------------------------"
  end


  # def async_create_archive(branch = 'default_branch')
  #   Resque.enqueue(Archive, id, branch)
  # end


  #Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end





  #Returns random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end





  def remember
    self.remember_token = ActiveSupport::MessageEncryptor.new(self.id)
    update_attribute(:remember_digest, remember_token)
  end





  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end




  def forget
    update_attribute(:remember_digest, nil)
  end



  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end



  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end



  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token) , reset_sent_at: Time.zone.now)
  end


  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end



  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end



  def feed
    Micropost.where("user_id IN (:following_ids) OR user_id = :user_id",
                    following_ids: self.following_ids, user_id: self.id)
  end



  def follow(other_user)
    following << other_user
  end



  def unfollow(other_user)
    following.delete(other_user)
  end



  def following?(other_user)
    following.include?(other_user)
  end





  private


    def downcase_email
      self.email.downcase!
    end


    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end



end
