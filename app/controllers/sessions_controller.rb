class SessionsController < ApplicationController

  def show
    if params[:registrationCode]
      session = get_session_by_registration_code(params[:registrationCode])
    end

    if session
      ret = {:name => session.name}
      render :json => ret, :status => :ok
    else
      render :nothing => true, :status => :not_found
    end
  end

end
