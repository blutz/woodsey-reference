class SessionsController < ApplicationController

  def create
    return unless validate_login_params
    return unless (user = find_user params[:email])
    authenticate_user user
  end

  def destroy
    log_out
  end

  private
  def validate_login_params
    errors = ActiveModel::Errors.new(User.new)
    if not params[:email]
      errors.add :email, 'must be present'
    end
    if not params[:password]
      errors.add :password, 'must be present'
    end
    if errors.empty?
      return true
    else
      render :json => errors.to_json, :status => :bad_request
      return false
    end
  end

  def find_user(email)
    errors = ActiveModel::Errors.new(User.new)
    user = User.find_by(email: email.downcase)
    if not user
      errors.add :email, 'is not a valid user'
      render :json => errors.to_json, :status => :not_found
    end
    user
  end

  def authenticate_user(user)
    if user.authenticate(params[:password])
      log_in user
      render :nothing => true, :status => :ok
    else
      errors = ActiveModel::Errors.new(user)
      errors.add :password, 'is not correct'
      render :json => errors.to_json, :status => :forbidden
    end
  end

end
