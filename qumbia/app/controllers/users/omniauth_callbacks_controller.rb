class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # Option 1
  def google_oauth2
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
  end

  # Option 2
  # def google_oauth2
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
  #   else
  #     session["devise.google_data"] = request.env["omniauth.auth"]
  #     redirect_to new_user_registration_url
  #   end
  # end

  # Option 3
  # def google_oauth2
  #   auth_details = request.env["omniauth.auth"]
  #   if auth_details.info['email'].split("@")[1] == "columbia.edu"
  #     # do all the bits that come naturally in the callback controller
  #     user = User.from_omniauth(request.env["omniauth.auth"])
  #     if @user.persisted?
  #       sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #       set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
  #     else
  #       session["devise.google_data"] = request.env["omniauth.auth"]
  #       redirect_to new_user_registration_url
  #     end
  #   else
  #     # This is where you turn away the poor souls who do not match your domain
  #     render :text => "Please use a Columbia email address (@columbia.edu)."
  #   end
  # end

  def failure
    redirect_to root_path
  end

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
