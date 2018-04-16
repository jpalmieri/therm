class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  validates_presence_of :name, :email, :password_digest
  has_secure_password # encrypt password
end
