require 'rails_helper'

RSpec.describe Temp, type: :model do
  it { should belong_to(:project) }
  it { should validate_presence_of(:value) }
end
