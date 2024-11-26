require "rails_helper"

RSpec.describe Api::V1::ETransportationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/e_transportations").to route_to("api/v1/e_transportations#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/e_transportations/1").to route_to("api/v1/e_transportations#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/e_transportations").to route_to("api/v1/e_transportations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/e_transportations/1").to route_to("api/v1/e_transportations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/e_transportations/1").to route_to("api/v1/e_transportations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/e_transportations/1").to route_to("api/v1/e_transportations#destroy", id: "1")
    end
  end
end
