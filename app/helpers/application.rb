require "#{PADRINO_ROOT}/config/faye_token"

DoubanFmHotkeyServer::App.helpers do

  def broadcast(channel, message)
    message.merge!(ext: { auth_token: FAYE_TOKEN })
    @client ||= Faye::Client.new(Settings.faye_url)
    @client.publish(channel, message)
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def logged_in?
    !!session[:user]
  end
end
