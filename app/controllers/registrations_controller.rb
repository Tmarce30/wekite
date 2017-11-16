class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(user, params)
    if user.provider != "facebook"
      user.update_with_password(params)
    else
      user.update_without_password(params)
    end
  end
end
