# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: ->(exception) { handler(exception) }
  end

  def render_unprocessable_entity(exception)
    render(
      json:   { errors: ErrorSerializer.new(exception.record).serialize },
      status: :unprocessable_entity
    )
  end

  def render_not_found(exception = nil)
    message = exception ? exception.message : 'Record Not Found'

    render(json: { errors: message }, status: :not_found)
  end

  def render_internal_server_error(*)
    render(
      json:   { errors: 'Internal Server Error' },
      status: :internal_server_error
    )
  end

  private

  def handler(exception)
    action   = error_mapping.key(exception.class)
    action ||= :render_internal_server_error

    method(action).call(exception)
  end

  def error_mapping
    {
      render_unprocessable_entity: ActiveRecord::RecordInvalid,
      render_not_found:            ActiveRecord::RecordNotFound
    }
  end
end
