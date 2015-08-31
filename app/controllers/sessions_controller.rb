class SessionsController < ApplicationController

  def show
    session = Session.where 'lower(registration_code) = ?', params[:registrationCode].downcase
    if session.any?
      ret = {:name => session[0].name}
      render :json => ret, :status => :ok
    else
      render :nothing => true, :status => :not_found
    end
  end

end
