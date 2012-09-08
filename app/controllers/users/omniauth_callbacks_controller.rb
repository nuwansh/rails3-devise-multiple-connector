class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
      link = "https://www.facebook.com/profile.php?id=#{request.env["omniauth.auth"]["uid"]}"
      # You need to implement the method below in your model
      @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
      puts @user.to_json
      puts current_user.to_json

      if user_signed_in? && @user == current_user

        flash[:notice] = "Successfully linked that account!"
        redirect_to edit_user_registration_path

      elsif !user_signed_in? && !@user.nil?

        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        sign_in_and_redirect @user, :event => :authentication

      elsif user_signed_in? && @user.nil? && params[:state] == "link_to_facebook"

        current_user.update_attributes({:facebook_link => link, :facebook_id => request.env["omniauth.auth"].extra.raw_info.id})
        redirect_to edit_user_registration_path

      elsif user_signed_in? && @user.persisted? && params[:state] == "link_to_facebook"

        flash[:notice] = "You have alredy used this Facebook account"
        redirect_to edit_user_registration_path
      else

        session["devise.app_data"] = request.env["omniauth.auth"].extra.raw_info
        session["devise.app_provider"] = request.env["omniauth.auth"].provider
        redirect_to facebook_registration_path
      end
  end

  def twitter
      link = "https://twitter.com/#{request.env["omniauth.auth"].extra.raw_info.screen_name}"

      # You need to implement the method below in your model
      @user = User.find_for_twitter_oauth(request.env["omniauth.auth"])

      if user_signed_in? && @user == current_user

        flash[:notice] = "Successfully logini!"
        redirect_to edit_user_registration_path

      elsif !user_signed_in? && !@user.nil?

        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
        sign_in_and_redirect @user, :event => :authentication

      elsif user_signed_in? && @user.nil? && params[:state] == "link_to_twitter"

        flash[:alert] = "Successfully linked that account!"
        current_user.update_attributes({:twitter_link => link, :twitter_id => request.env["omniauth.auth"].extra.raw_info.id})
        redirect_to edit_user_registration_path

      elsif user_signed_in? && @user.persisted? && params[:state] == "link_to_twitter"

        flash[:alert] = "You have alredy used this Twitter account"
        redirect_to edit_user_registration_path
      else

        session["devise.app_data"] = request.env["omniauth.auth"].extra.raw_info
        session["devise.app_provider"] = request.env["omniauth.auth"].provider

        redirect_to twitter_registration_path
      end
  end

  def google_oauth2
    link = request.env["omniauth.auth"].extra.raw_info.link

    # You need to implement the method below in your model
    @user = User.find_for_google_oauth(request.env["omniauth.auth"])

    if user_signed_in? && @user == current_user

      flash[:notice] = "Successfully linked that account!"
      redirect_to edit_user_registration_path

    elsif !user_signed_in? && !@user.nil?

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication

    elsif user_signed_in? && @user.nil? && params[:state] == "link_to_google"

      flash[:alert] = "Successfully linked that account!"
      current_user.update_attributes({:google_link => link, :google_id => request.env["omniauth.auth"].extra.raw_info.id})
      redirect_to edit_user_registration_path

    elsif user_signed_in? && @user.persisted? && params[:state] == "link_to_google"

      flash[:notice] = "You have alredy used this Google account"
      redirect_to edit_user_registration_path

    else
      session["devise.app_data"] = request.env["omniauth.auth"].extra.raw_info
      session["devise.app_provider"] = request.env["omniauth.auth"].provider

      redirect_to google_registration_path
    end

  end 

  def linkedin 
    link = request.env["omniauth.auth"].extra.raw_info.publicProfileUrl
    # You need to implement the method below in your model
    @user = User.find_for_linkedin_oauth(request.env["omniauth.auth"])

    if user_signed_in? && @user == current_user

      flash[:notice] = "Successfully linked that account!"
      redirect_to edit_user_registration_path

    elsif !user_signed_in? && !@user.nil?

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Linkedin"
      sign_in_and_redirect @user, :event => :authentication

    elsif user_signed_in? && @user.nil? && params[:state] == "link_to_linkedin"

      flash[:alert] = "Successfully linked that account!"
      current_user.update_attributes({:linkedin_link => link, :linkedin_id => request.env["omniauth.auth"].extra.raw_info.id})
      redirect_to edit_user_registration_path

    elsif user_signed_in? && @user.persisted? && params[:state] == "link_to_linkedin"

      flash[:notice] = "You have alredy used this Linkedin account"
      redirect_to edit_user_registration_path

    else

      session["devise.app_data"] = request.env["omniauth.auth"].info
      session["devise.app_data"]["id"] = request.env["omniauth.auth"].extra.raw_info.id
      session["devise.app_provider"] = request.env["omniauth.auth"].provider

      redirect_to linkedin_registration_path
    end
  end

end
