class SessionsController < ApplicationController
  require "losant_rest"
  require "http"

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        # cookies.permanent[:auth_token] = user.auth_token
      else
        # cookies[:auth_token] = user.auth_token
        session[:user_id] = user.id
      end

      #========================================================#
      # Check authenticate user with Losant
      #
      #        59d54e901dd3d200070cd75b
      #
      #========================================================#
      begin
        urlApi =  "https://" + ENV['LOSANT_APP_ID'] + ".onlosant.com/auth"
        response = HTTP.post(urlApi, :json => { :email => params[:email], :password => params[:password] })
        if response.parse['token']
          session[:losant_auth_token] = response.parse['token']
          # @authStatus = session[:losant_auth_token]
          redirect_to root_path
        else
          flash[:failure] =  "User Unauthorized with Losant"
          redirect_to login_path
        end
      rescue => e
        flash[:failure] =  e
        redirect_to login_path
      end
      #========================================================#
      # End check authenticate user with Losant
      #========================================================#
    else
      flash[:failure] = "Incorrect password and email combination"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    # cookies.delete(:auth_token)
    redirect_to root_path
  end

end
