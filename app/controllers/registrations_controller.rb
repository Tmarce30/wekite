class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

  def update_resource(user, params)
    if user.provider != "facebook"
      user.update_with_password(params)
    else
      user.update_without_password(params)
    end
  end
end
