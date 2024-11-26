require 'swagger_helper'

RSpec.describe "/api/v1/e_transportations", type: :request do
  let(:create_owner) { create(:owner) }
  let(:create_e_bike) { create(:e_bike, owner: create_owner) }
  let(:create_e_scooter) { create(:e_scooter, owner: create_owner) }
  let(:create_e_bikes) { create_list(:e_bike, 10, owner: create_owner) }
  let(:create_e_scooters) { create_list(:e_scooter, 10, owner: create_owner) }
  let(:create_e_transportations) do
    create_e_bikes
    create_e_scooters

    ETransportation.all
  end

  path '/api/v1/e_transportations/outside_power_report' do
    get 'Report of e-Transportations outside power' do
      tags 'ETransportations'
      consumes 'application/json'
      response '200', 'report found' do
        before do
          create_e_transportations
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response.status).to eq(200)
          expect(data['e_bike']['total']).to eq(EBike.not_in_zone.count)
          expect(data['e_scooter']['total']).to eq(EScooter.not_in_zone.count)
        end
      end
    end
  end

  path '/api/v1/e_transportations' do
    get 'List all e-Transportations' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :type, in: :query, schema: { type: :string, enum: [ 'EBike', 'EScooter' ] }, required: false, description: 'Type of transportation'
      response '200', 'e_transportations found' do
        before do
          create_e_transportations
        end

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportations']
          expect(response.status).to eq(200)
          expect(data.size).to eq(create_e_transportations.size)
          expect(data.first['owner_id']).to eq(create_owner.id)
          expect(data.first['sensor_type']).to eq(create_e_transportations.first.sensor_type)
          expect(data.first['in_zone']).to eq(create_e_transportations.first.in_zone)
        end
      end

      response '200', 'e_bikes found' do
        let(:type) { 'EBike' }

        before do
          create_e_transportations
        end

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportations']
          expect(response.status).to eq(200)
          expect(data.size).to eq(create_e_bikes.size)
          expect(data.first['owner_id']).to eq(create_owner.id)
          expect(data.first['sensor_type']).to eq(create_e_bikes.first.sensor_type)
          expect(data.first['in_zone']).to eq(create_e_bikes.first.in_zone)
        end
      end

      response '200', 'e_scooters found' do
        let(:type) { 'EScooter' }

        before do
          create_e_transportations
        end

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportations']
          expect(response.status).to eq(200)
          expect(data.size).to eq(create_e_scooters.size)
          expect(data.first['owner_id']).to eq(create_owner.id)
          expect(data.first['sensor_type']).to eq(create_e_scooters.first.sensor_type)
          expect(data.first['in_zone']).to eq(create_e_scooters.first.in_zone)
        end
      end
    end

    post 'Create a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :type, in: :query, schema: { type: :string, enum: [ 'EBike', 'EScooter' ] }, required: true, description: 'Type of transportation'
      parameter name: :e_transportation, in: :body, schema: {
        type: :object,
        properties: {
          owner_id: { type: :integer },
          sensor_type: { type: :string, enum: [ 'small', 'medium', 'large' ] },
          lost_sensor: { type: :boolean },
          in_zone: { type: :boolean }
        },
        required: [ 'owner_id', 'sensor_type' ]
      }

      response '201', 'e_bike created' do
        let(:type) { 'EBike' }
        let(:e_transportation) { { owner_id: create_owner.id, sensor_type: "small", in_zone: true } }

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportation']
          expect(response.status).to eq(201)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['type']).to eq(type)
          expect(data['sensor_type']).to eq(e_transportation[:sensor_type])
          expect(data['in_zone']).to eq(e_transportation[:in_zone])
          expect(data['lost_sensor']).to eq(e_transportation[:lost_sensor])
        end
      end

      response '201', 'e_scooter created' do
        let(:type) { 'EScooter' }
        let(:e_transportation) { { owner_id: create_owner.id, sensor_type: "small", in_zone: true, lost_sensor: false } }

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportation']
          expect(response.status).to eq(201)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['type']).to eq(type)
          expect(data['sensor_type']).to eq(e_transportation[:sensor_type])
          expect(data['in_zone']).to eq(e_transportation[:in_zone])
          expect(data['lost_sensor']).to eq(e_transportation[:lost_sensor])
        end
      end

      response '422', 'invalid request' do
        let(:type) { 'EBike' }
        let(:e_transportation) { { owner_id: nil, sensor_type: 'no_data', in_zone: nil } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response.status).to eq(422)
          expect(data['fields']['sensor_type']).to eq([ "is not included in the list" ])
        end
      end
    end
  end

  path '/api/v1/e_transportations/{id}' do
    get 'Show a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :type, in: :query, schema: { type: :string, enum: [ 'EBike', 'EScooter' ] }, required: false, description: 'Type of transportation'

      response '200', 'e_transportation found' do
        let(:id) { create_e_bike.id }

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportation']
          expect(response.status).to eq(200)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['sensor_type']).to eq(create_e_bike.sensor_type)
          expect(data['in_zone']).to eq(create_e_bike.in_zone)
        end
      end

      response '404', 'e_transportation not found' do
        let(:id) { 0 }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response.status).to eq(404)
          expect(data['error']).to eq("Couldn't find ETransportation with 'id'=#{id}")
        end
      end
    end

    put 'Update a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :type, in: :query, schema: { type: :string, enum: [ 'EBike', 'EScooter' ] }, required: false, description: 'Type of transportation'
      parameter name: :e_transportation, in: :body, schema: {
        type: :object,
        properties: {
          owner_id: { type: :integer },
          sensor_type: { type: :string },
          lost_sensor: { type: :boolean },
          in_zone: { type: :boolean }
        },
        required: [ 'owner_id', 'sensor_type' ]
      }

      response '200', 'e_bike updated' do
        let(:id) { create_e_bike.id }
        let(:type) { 'EBike' }
        let(:e_transportation) { { owner_id: create_owner.id, sensor_type: "small", in_zone: true, lost_sensor: false } }

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportation']
          expect(response.status).to eq(200)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['type']).to eq(type)
          expect(data['sensor_type']).to eq(e_transportation[:sensor_type])
          expect(data['in_zone']).to eq(e_transportation[:in_zone])
        end
      end

      response '200', 'e_scooter updated' do
        let(:id) { create_e_scooter.id }
        let(:type) { 'EScooter' }
        let(:e_transportation) { { owner_id: create_owner.id, sensor_type: "small", in_zone: true } }

        run_test! do |response|
          data = JSON.parse(response.body)['e_transportation']
          expect(response.status).to eq(200)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['type']).to eq(type)
          expect(data['sensor_type']).to eq(e_transportation[:sensor_type])
          expect(data['in_zone']).to eq(e_transportation[:in_zone])
        end
      end

      response '422', 'invalid request' do
        let(:id) { create_e_bike.id }
        let(:type) { 'EBike' }
        let(:e_transportation) { { owner_id: nil, sensor_type: "test", in_zone: nil } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response.status).to eq(422)
          expect(data['fields']['sensor_type']).to eq([ "is not included in the list" ])
        end
      end
    end

    delete 'Delete a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :type, in: :query, schema: { type: :string, enum: [ 'EBike', 'EScooter' ] }, required: false, description: 'Type of transportation'

      response '204', 'e_transportation deleted' do
        let(:id) { create_e_bike.id }
        run_test!
      end

      response '404', 'e_transportation not found' do
        let(:id) { 0 }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(response.status).to eq(404)
          expect(data['error']).to eq("Couldn't find ETransportation with 'id'=#{id}")
        end
      end
    end
  end
end
