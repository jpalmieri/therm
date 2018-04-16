FactoryBot.define do
  factory :temp do
    value { rand(0.00001..999.999).round(3) }
    project_id nil
  end
end
