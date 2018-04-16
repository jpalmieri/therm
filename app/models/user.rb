class User < ApplicationRecord
  has_secure_password # encrypt password
  has_many :projects, dependent: :destroy
  validates_presence_of :name, :email, :password_digest
end
