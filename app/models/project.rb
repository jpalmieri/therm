class Project < ApplicationRecord
  has_many :temps, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
end
