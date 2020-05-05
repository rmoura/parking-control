# frozen_string_literal: true

Rails.application.routes.draw do
  mount OpenApi::Rswag::Ui::Engine  => '/api-docs'
  mount OpenApi::Rswag::Api::Engine => '/api-docs'

  root 'health_check/health_check#index', defaults: { format: :json }

  namespace :v1, path: '' do
    resource :tickets, only: %i[create], path: 'parking' do
      put '/:id/out', action: :out
      put '/:id/pay', action: :pay
      get '/:plate',  action: :show
    end
  end

  match '*any', to: 'application#not_found', via: :all
end
