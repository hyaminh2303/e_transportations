# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

owner_names = [
  "John Doe",
  "Jane Doe",
  "Alice",
  "Bob",
  "Charlie",
]

owner_names.each do |owner_name|
  Owner.find_or_create_by!(name: owner_name)
end

owner_ids = Owner.pluck(:id)

10.times do
  EBike.create!(
    owner_id: owner_ids.sample,
    sensor_type: EBike.sensor_types.keys.sample,
    in_zone: [true, false].sample,
    lost_sensor: [true, false].sample,
  )
end

10.times do
  EScooter.create!(
    owner_id: owner_ids.sample,
    sensor_type: EScooter.sensor_types.keys.sample,
    in_zone: [true, false].sample,
    lost_sensor: [true, false].sample,
  )
end
