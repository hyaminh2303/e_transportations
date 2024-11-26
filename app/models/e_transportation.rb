class ETransportation < ApplicationRecord
  belongs_to :owner
end

# == Schema Information
#
# Table name: e_transportations
#
#  id                    :integer          not null, primary key
#  e_transportation_type :string
#  in_zone               :boolean
#  lost_sensor           :boolean
#  sensor_type           :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  owner_id              :integer          not null
#
# Indexes
#
#  index_e_transportations_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  owner_id  (owner_id => owners.id)
#
