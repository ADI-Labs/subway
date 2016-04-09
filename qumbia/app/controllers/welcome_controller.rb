class WelcomeController < ApplicationController
  def index
  	render layout: "../views/layouts/welcome.html.erb" 
  end
end
