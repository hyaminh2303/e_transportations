class EScooter < ETransportation
  enum :sensor_type, {
    small: "small",
    big: "big"
  }, prefix: true, validate: true
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
#  owner_id    :integer
#
# Indexes
#
#  index_e_transportations_on_owner_id  (owner_id)
#
