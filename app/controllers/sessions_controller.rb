class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		redirect_path = events_path
  		if session[:protected_page]
  			redirect_path = session[:protected_page]
  			session[:protected_page] = nil
  		end
  		login(user)
  		redirect_to redirect_path, notice: 'Logged In'
  	else
  		redirect_to root_path, alert: 'Invalid Email/Password'
  	end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged Out'
  end
end
