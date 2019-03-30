class ApplicationController < ActionController::Base

  protected
  def after_sign_up_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    #strong parametersを設定し、usernameを許可
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  end
end
