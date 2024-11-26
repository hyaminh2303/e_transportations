class Api::V1::BaseController < ApplicationController
  include Pagy::Backend

  def find_resource(klass, id)
    klass.find(id)
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: e.message, message: e.message }, status: :not_found
  end

  def render_success(message)
    render json: { message: }
  end

  def render_error(
    resource_or_message,
    status: unprocessable_entity,
    error_field: nil,
    custom_messages: nil
  )
    if resource_or_message.is_a?(String)
      formatted_messages = resource_or_message,
      full_messages = [ resource_or_message ],
      fields = { "#{error_field.presence || :base}": [ resource_or_message ] }
    else
      formatted_messages = custom_messages.presence || resource_or_message.errors.full_messages.join(", "), # String of errors
      full_messages = resource_or_message.errors.full_messages, # Array of errors
      fields = resource_or_message.errors.as_json # errors group by field
    end

    render json: {
      formatted_messages: formatted_messages,
      full_messages: full_messages,
      fields: fields
    }, status: status
  end
end
