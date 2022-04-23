# frozen_string_literal: true

module Api
  # Base controller for all APIs
  class BaseController < ApplicationController
    # Schema Validation
    def validate_schema
      controller_params = { controller_name: controller_name, action_name: action_name }
      valid, error = SchemaValidator.new(params, controller_params).validate

      # rubocop:disable Style/GuardClause
      unless valid
        render json: {
          error: JSON.parse(error.message),
          status: 422
        }, status: 422
      end
      # rubocop:enable Style/GuardClause
    end
  end
end
