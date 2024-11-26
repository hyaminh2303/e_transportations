class ETransportation < ApplicationRecord
  belongs_to :owner, optional: true

  validates :sensor_type, :type, presence: true

  scope :not_in_zone, -> { where(in_zone: false) }

  class << self
    def outside_power_report
      report = {
        e_bike: outside_power_report_for(EBike),
        e_scooter: outside_power_report_for(EScooter)
      }

      report[:total] = report.values.pluck(:total).sum

      report
    end

    def outside_power_report_for(klass)
      report = {}

      sensor_type_count = klass.not_in_zone.group(:sensor_type).count(:sensor_type)

      klass.sensor_types.keys.each do |sensor_type|
        report[sensor_type] = sensor_type_count[sensor_type.to_s] || 0
      end

      report[:total] = report.values.sum

      report
    end
  end
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
