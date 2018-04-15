class Temp < ApplicationRecord
  belongs_to :project
  validates_presence_of :value
end
