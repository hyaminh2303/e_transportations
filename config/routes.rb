Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :e_transportations do
        collection do
          get :outside_power_report
        end
      end
    end
  end
end
