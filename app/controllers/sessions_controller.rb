class SessionsController < ApplicationController

  def show
    session = Session.find_by registration_code: params[:registrationCode]
    if session
      ret = {:name => session.name}
      render :json => ret, :status => :ok
    else
      render :nothing => true, :status => :not_found
    end
  end

end
