class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    return admin_dash_boards_path if resource.admin?
    return creator_assets_path if resource.creator?
    return customer_assets_path if resource.customer?
  end


  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def after_sign_up_path_for(resource)
    return admin_dash_boards_path if resource.admin?
    return creator_assets_path if resource.creator?
    return customer_assets_path if resource.customer?
  end

  def require_customer!
    redirect_to root_path, alert: "Only customers can make purchases" unless current_user.customer?
  end

  def require_creator!
    redirect_to root_path, alert: "Only creator can make assets" unless current_user.creator?
  end

  def require_admin!
    redirect_to root_path, alert: "Only admin require" unless current_user.admin?
  end

  protected

  def configure_permitted_parameters
    # For sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    # For account update
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
