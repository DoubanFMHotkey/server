DoubanFmHotkeyServer::App.helpers do


  def broadcast(channel, message)
    @client ||= Faye::Client.new(settings.faye_url)
    @client.publish(channel, message)
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def logged_in?
    !!session[:user]
  end
end
