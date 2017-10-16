module ApplicationHelper

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    return true if current_user && session[:user_id]
  end

  # def current_user
  #   @user ||= User.find_by(auth_token: cookies[:auth_token]) if cookies[:auth_token]
  # end
  #
  # def logged_in?
  #   return true if current_user && cookies[:auth_token]
  # end

  def require_log_in
    redirect_to root_path unless logged_in?
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
end
