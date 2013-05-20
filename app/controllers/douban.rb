DoubanFmHotkeyServer::App.controllers :douban do

  before except: :client do
    api_key = ApiKey.find_by_access_token(params[:access_token])
    halt 401, 'Not authorized.' if api_key.nil?
  end

  %w{skip pause love ban info}.each do |cmd|
    get cmd.to_sym,  map: "/douban/#{cmd}" do
      @client = Faye::Client.new(settings.faye_url)
      @client.publish('/hotkey', {cmd: cmd})
    end
  end

  get :client, map: '/douban/client.js' do
    render 'douban/client.js'
  end

end
