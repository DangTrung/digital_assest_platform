class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!

  # def after_sign_in_path_for(resource)
  #   creator_assets_path # or your custom path, e.g., dashboard_path
  # end
  
  def after_sign_out_path_for(resource_or_scope)
    root_path # or any path you want, like new_user_session_path
  end

  def after_sign_up_path_for(resource)
    creator_assets_path
  end  
end
