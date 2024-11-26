require 'swagger_helper'

RSpec.describe "/api/v1/e_transportations", type: :request do
  let(:create_owner) { create(:owner) }
  let(:create_e_transportation) { create(:e_transportation, owner: create_owner) }
  let(:create_e_transportations) { create_list(:e_transportation, 10, owner: create_owner) }

  path '/api/v1/e_transportations' do
    get 'List all e-Transportations' do
      tags 'ETransportations'
      consumes 'application/json'

      response '200', 'e_transportations found' do
        before do
          create_e_transportations
         end

        run_test!
      end
    end

    post 'Create a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :e_transportation, in: :body, schema: {
        type: :object,
        properties: {
          owner_id: { type: :integer },
          sensor_type: { type: :string },
          in_zone: { type: :boolean }
        },
        required: [ 'owner_id', 'sensor_type', 'in_zone' ]
      }

      response '201', 'e_transportation created' do
        let(:e_transportation) { { owner_id: create_owner.id, sensor_type: 'sensor_type', in_zone: true } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['sensor_type']).to eq('sensor_type')
          expect(data['in_zone']).to eq(true)
        end
      end
    end
  end

  path '/api/v1/e_transportations/{id}' do
    get 'Show a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'e_transportation found' do
        let(:id) { create_e_transportation.id }
        run_test!
      end
    end

    put 'Update a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :e_transportation, in: :body, schema: {
        type: :object,
        properties: {
          owner_id: { type: :integer },
          sensor_type: { type: :string },
          in_zone: { type: :boolean }
        },
        required: [ 'owner_id', 'sensor_type', 'in_zone' ]
      }

      response '200', 'e_transportation updated' do
        let(:id) { create_e_transportation.id }
        let(:e_transportation) { { owner_id: create_owner.id, sensor_type: 'sensor_type', in_zone: true } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['owner_id']).to eq(create_owner.id)
          expect(data['sensor_type']).to eq('sensor_type')
          expect(data['in_zone']).to eq(true)
        end
      end
    end

    delete 'Delete a e-Transportation' do
      tags 'ETransportations'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'e_transportation deleted' do
        let(:id) { create_e_transportation.id }
        run_test!
      end
    end
  end
end
