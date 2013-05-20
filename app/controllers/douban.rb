DoubanFmHotkeyServer::App.controllers :douban do

  before except: :client do
    api_key = ApiKey.find_by_access_token(params[:access_token])
    halt 401, 'Not authorized.' if api_key.nil?
  end

  %w{skip pause love ban info}.each do |cmd|
    get cmd.to_sym,  map: "/douban/#{cmd}" do
      broadcast("/hotkey/#{api_key.access_token}", {cmd: cmd})
    end
  end

  get :client, map: '/douban/client.js' do
    @access_token = current_user.api_key.access_token
    headers "Content-Type" => 'text/javascript'
    render 'douban/client.js'
  end

end
