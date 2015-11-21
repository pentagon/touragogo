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
end
