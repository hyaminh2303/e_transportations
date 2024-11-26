FactoryBot.define do
  factory :e_transportation do
    association :owner, factory: :owner

    sensor_type { Faker::Lorem.word }
    in_zone { Faker::Boolean.boolean }
  end
end
