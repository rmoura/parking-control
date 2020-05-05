# frozen_string_literal: true

Rails.application.routes.draw do

  root 'health_check/health_check#index', defaults: { format: :json }
end
