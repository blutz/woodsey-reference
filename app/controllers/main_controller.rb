class MainController < ApplicationController
  def index
    redirect_to app_url if current_user
  end

  def app
    redirect_to home_url unless current_user
  end
end
