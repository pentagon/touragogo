class Users::RegistrationsController < Devise::RegistrationsController

  def new_guide
    build_resource({role: User::ROLES[:guide]})
    set_minimum_password_length
    respond_with self.resource
  end

  def new_tourist
    build_resource({role: User::ROLES[:tourist]})
    set_minimum_password_length
    respond_with self.resource
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      redirect_path = params[:user][:role].to_i == User::ROLES[:guide] ? users_sign_up_guide_path : users_sign_up_tourist_path
      redirect_to redirect_path
    end
  end
end
