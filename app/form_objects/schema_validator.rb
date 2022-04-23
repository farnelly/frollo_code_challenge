# frozen_string_literal: true

# JSON schema validator
class SchemaValidator
  attr_accessor :path, :params

  def initialize(params, controller_params)
    @params = params
    @path = schema_path(controller_params)
  end

  def validate
    errors = JSON::Validator.fully_validate(path, params.to_json)
    valid = errors.empty?
    # In array validation it gives duplicate error message
    # so, to get unique error message error.uniq is used
    error = fetch_custom_errors(errors.uniq) unless valid
    [valid, error]
  end

  private

  def schema_path(controller_params)
    controller_name = controller_params[:controller_name]
    action_name = controller_params[:action_name]
    root_path = Rails.root.join('app', 'controllers', 'api', 'schemas').to_s
    root_path + "/#{controller_name}/#{action_name}.json"
  end

  def fetch_custom_errors(errors)
    error_messages = JSONSchemaErrorParser.parse(errors)
    raise JSON::Schema::CustomFormatError, error_messages
  rescue JSON::Schema::CustomFormatError => e
    e
  end
end
