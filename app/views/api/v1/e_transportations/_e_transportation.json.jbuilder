json.extract! e_transportation, :id, :type, :sensor_type, :owner_id, :in_zone, :created_at, :updated_at

if e_transportation.is_a?(EScooter)
  json.lost_sensor e_transportation.lost_sensor?
end
