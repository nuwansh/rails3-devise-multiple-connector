class RegistrationsController < Devise::RegistrationsController


  def update
    #Changes params
    params[resource_name].delete(:password) if params[resource_name][:password].blank?
    params[resource_name].delete(:password_confirmation) if params[resource_name][:password_confirmation].blank?

    # Override Devise to use update_attributes instead of update_with_password.
    # This is the only change we make.
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      #after update the user account form, just keep the save page 
      #redirect_to after_update_path_for(resource)
      redirect_to edit_user_registration_path
    else
      clean_up_passwords(resource)
      render :edit
    end
  end
end
