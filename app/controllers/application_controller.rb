# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ErrorHandler
  include Serializable

  def not_found
    render json: { errors: 'API endpoint Not Found!' }, status: :not_found
  end
end
