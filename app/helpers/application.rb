require "#{PADRINO_ROOT}/config/faye_token"

DoubanFmHotkeyServer::App.helpers do

  def broadcast(channel, data)
    message = {:channel => channel, :data => data, :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse(Settings.faye_url)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def logged_in?
    !!session[:user]
  end
end
