class User < ActiveRecord::Base

  validates :name, presence: true, format: /\s*\w+\s+\w+\s*/
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}

  validates_confirmation_of :password

  has_secure_password
  

  def authenticate_with_credentials(email, password)
    user = User.find_by(email: email).authenticate(password)
    user ? user : nil
  end

end
