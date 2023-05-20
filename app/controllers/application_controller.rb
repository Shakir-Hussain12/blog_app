class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  include Devise::Controllers::Helpers
  before_action :allowed_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: -> { request.format.json? }

  protected

  def allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name photo bio email password current_password])
  end
end
