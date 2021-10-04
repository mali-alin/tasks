class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password]
      )
  end

  def current_user_can_edit?(task)
    user_signed_in? && task.user == current_user
  end

  def current_user_can_edit_approval?(approval)
    user_signed_in? && approval.user == current_user
  end
end
