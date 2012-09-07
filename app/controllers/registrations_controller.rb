class RegistrationsController < Devise::RegistrationsController
  before_filter :create_app_user, :only => [:facebook, :twitter, :google, :linkedin]

  respond_to :html

# def new
#   data = session["devise.app_data"]
# end
#
# def facebook
#   provider  = session["devise.app_provider"]
#   data      = session["devise.app_data"]
#
#   @user = User.new(
#      :email => data.email,
#      :first_name => data.name
#   )
#   @user.provider =  provider
#
#   respond_with(@user)
# end
#
# def twitter
#   provider  = session["devise.app_provider"]
#   data      = session["devise.app_data"]
#
#   @user = User.new(
#      :email => data.email,
#      :first_name => data.name
#   )
#   @user.provider =  provider
#
#   respond_with(@user)
# end
#
# def google
#   provider  = session["devise.app_provider"]
#   data      = session["devise.app_data"]
#
#   @user = User.new(
#      :email => data.email,
#      :first_name => data.name
#   )
#   @user.provider =  provider
#
#   respond_with(@user)
# end
#
# def linkedin
#   provider  = session["devise.app_provider"]
#   data      = session["devise.app_data"]
#
#   @user = User.new(
#      :email => data.email,
#      :first_name => data.name
#   )
#   @user.provider =  provider
#
#   respond_with(@user)
# end

  # POST /resource
  def create
    provider  = session["devise.app_provider"]
    data      = session["devise.app_data"]
    puts data.to_json

    build_resource

    resource.first_name     = data.name
    resource.provider       = provider
    resource.confirmed_at   = DateTime.now

    if provider == "facebook"
      resource.facebook_link  = "https://www.facebook.com/profile.php?id=#{data.id}"
      resource.facebook_id    = data.id
    elsif  provider == "twitter"
      resource.twitter_link  = "https://twitter.com/#{data.screen_name}"
      resource.twitter_id    = data.id
    elsif provider == "google_oauth2"
      resource.first_name   = data.name
      resource.google_link  = data.link
      resource.google_id    = data.id
    elsif provider == "linkedin"
      resource.first_name = data.first_name
      resource.last_name = data.last_name
      resource.linkedin_link  = data.urls.public_profile
      resource.linkedin_id    = data.id
    end

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

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

  def deactivate
    #@user = User.find(current_user.id)
    provider_id = "#{params[:network]}_id".to_sym
    profile_link = "#{params[:network]}_link".to_sym

   respond_to do |format|
     #update social networks for users
     if current_user.update_attributes({provider_id => nil, profile_link => nil})
         format.html { redirect_to edit_user_registration_path }
     end
   end
  end

  protected
  def create_app_user
    provider  = session["devise.app_provider"]
    data      = session["devise.app_data"]

    @user = User.new(
       :email => data.email,
       :first_name => data.name
    )
    @user.provider =  provider
  end
end
