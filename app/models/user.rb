class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)

    if user && user.authenticate(password)
      return user
    else
      return nil
    end

  end
end
