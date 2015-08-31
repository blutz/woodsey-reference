class UsersController < ApplicationController

  def create
    user = User.new(
      :camp_name => params[:campName],
      :real_name => params[:realName],
      :password => params[:password],
      :email => params[:email]
    )
    session = get_session_by_registration_code params[:registrationCode]
    if session
      user.sessions << session
      valid_registration_code = true
    else
      valid_registration_code = false
    end

    if user.valid? and valid_registration_code and user.save
      render :nothing => true, :status => :ok
    else
      if not valid_registration_code
        user.errors.add :registration_code, 'is not valid'
      end
      render :json => user.errors.to_json, :status => :bad_request
    end

  end

end
