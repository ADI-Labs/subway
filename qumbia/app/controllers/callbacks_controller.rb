class CallbacksController < Devise::OmniauthCallbacksController
    def google_oath2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
    end
end