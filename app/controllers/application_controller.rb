class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    end

  private

    def record_not_found(error)
      render json: { error: error.message }, status: :not_found
    end
end
