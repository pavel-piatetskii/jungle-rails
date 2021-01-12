class User < ActiveRecord::Base

  validates :name, presence: true, format: /\s*\w+\s+\w+\s*/
  validates :email, presence: true
  validates :password, presence: true

  validates_confirmation_of :password

  has_secure_password
  
end
