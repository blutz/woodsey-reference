class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "application"

  def index
    session[:hi] = 'ho'
  end

  private

  def get_session_by_registration_code(code)
    s = Session.where 'lower(registration_code) = ?', code.downcase
    s.any? ? s[0] : nil
  end

  def log_in(user)
    reset_session # Prevent session fixation
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

end
