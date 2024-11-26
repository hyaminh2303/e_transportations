FactoryBot.define do
  factory :e_bike do
    association :owner, factory: :owner

    type { 'EBike' }
    sensor_type { EBike.sensor_types.keys.sample }
    in_zone { Faker::Boolean.boolean }
    lost_sensor { Faker::Boolean.boolean }
  end
end
