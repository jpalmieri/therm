class Project < ApplicationRecord
  has_many :temps, dependent: :destroy
  validates_presence_of :name, :description
end
