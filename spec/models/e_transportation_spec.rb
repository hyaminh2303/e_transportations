require 'rails_helper'

RSpec.describe ETransportation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:owner) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:sensor_type) }
    it { is_expected.to validate_presence_of(:type) }
  end

  describe 'scopes' do
    let!(:in_zone_transport) { create(:e_bike, in_zone: true) }
    let!(:out_of_zone_transport) { create(:e_bike, in_zone: false) }

    describe '.not_in_zone' do
      it 'returns only transports that are not in the zone' do
        expect(described_class.not_in_zone).to eq([ out_of_zone_transport ])
      end
    end
  end

  describe 'class methods' do
    let!(:e_bike_1) { create(:e_bike, sensor_type: 'small', in_zone: false) }
    let!(:e_bike_2) { create(:e_bike, sensor_type: 'big', in_zone: true) }
    let!(:e_scooter) { create(:e_scooter, sensor_type: 'small', in_zone: false) }
    let!(:in_zone_e_bike) { create(:e_bike, sensor_type: 'big', in_zone: true) }

    describe '.outside_power_report' do
      it 'generates a report for e_bike and e_scooter outside power' do
        report = described_class.outside_power_report

        expect(report[:e_bike]['small']).to eq(1)
        expect(report[:e_bike]['big']).to eq(0)
        expect(report[:e_scooter]['small']).to eq(1)
        expect(report[:total]).to eq(2)
      end
    end

    describe '.outside_power_report_for' do
      it 'generates a report for the given class' do
        report = described_class.outside_power_report_for(EBike)

        expect(report['small']).to eq(1)
        expect(report['big']).to eq(0)
        expect(report[:total]).to eq(1)
      end
    end
  end
end
