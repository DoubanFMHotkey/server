require "#{PADRINO_ROOT}/config/faye_token"
require 'net/http'

DoubanFmHotkeyServer::App.helpers do

  def broadcast(channel, data)
    message = {:channel => channel, :data => data, :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse(Settings.faye_url)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def current_user
    return @current_user if @current_user
    if session[:user]
      @current_user = User.find(session[:user])
    elsif params[:access_token]
      api_key = ApiKey.find_by_access_token(params[:access_token])
      return nil if api_key.nil?
      @current_user = api_key.user
    end
  end

  def logged_in?
    !!session[:user]
  end
end
