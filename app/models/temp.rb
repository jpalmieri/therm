class Temp < ApplicationRecord
  belongs_to :project
  validates :value, presence: true
end
