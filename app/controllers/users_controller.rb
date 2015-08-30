class UsersController < ApplicationController

  def create
    user = User.new(
      :camp_name => params[:campName],
      :real_name => params[:realName],
      :password => params[:password],
      :email => params[:email]
    )
    if user.valid? and user.save
      render :nothing => true, :status => :ok
    else
      render :json => user.errors.to_json, :status => :bad_request
    end

  end

end
