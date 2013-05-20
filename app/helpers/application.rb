DoubanFmHotkeyServer::App.helpers do
  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def logged_in?
    !!session[:user]
  end
end
