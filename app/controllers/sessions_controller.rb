class SessionsController < ApplicationController
skip_before_action :authorize
  def new
  end

  def create
    if User.count.zero?
      logger.debug "Params: #{params}"
      name = params[:name]
      user = User.create(name: name, password: name, password_confirmation: name)
      user.save
      user.authenticate(name)
      session[:user_id] = user.id
      redirect_to admin_url, alert: 'First admin created.'
      return
    end
  	user = User.find_by(name: params[:name])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to admin_url
    else
      redirect_to login_url, alert: 'Invalid user/password combination'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "logged out"
  end
end
