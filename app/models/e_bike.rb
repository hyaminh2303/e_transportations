class EBike < ETransportation
  enum :sensor_type, {
    small: "small",
    medium: "medium",
    big: "big"
  }, prefix: true
end

# == Schema Information
#
# Table name: e_transportations
#
#  id          :integer          not null, primary key
#  in_zone     :boolean          default(FALSE), not null
#  lost_sensor :boolean          default(FALSE), not null
#  sensor_type :string
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer          not null
#
# Indexes
#
#  index_e_transportations_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  owner_id  (owner_id => owners.id)
#
