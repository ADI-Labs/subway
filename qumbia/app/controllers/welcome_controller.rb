class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
      if user_signed_in?
          redirect_to :controller => :questions, :action => 'index'
      end
  end
  
  def resource_name
	:user
  end

  def resource
	@resource ||= User.new
  end

  def devise_mapping
 	@devise_mapping ||= Devise.mappings[:user]
  end
end
