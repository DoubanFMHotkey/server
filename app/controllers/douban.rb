DoubanFmHotkeyServer::App.controllers :douban do

  before except: :client do
    @api_key = ApiKey.find_by_access_token(params[:access_token])
    halt 401, 'Not authorized.' if @api_key.nil?
  end

  %w{skip pause love ban info}.each do |cmd|
    get cmd.to_sym,  map: "/douban/#{cmd}" do
      broadcast("/hotkey/#{@api_key.access_token}", {cmd: cmd})
    end
  end

  get :client, map: '/douban/client.js' do
    headers "Content-Type" => 'text/javascript'
    render 'douban/client.js'
  end

  get :get_info, map: '/douban/get_info' do
    broadcast("/get_info/#{@api_key.access_token}", {get: true})
    ''
  end

  get :publish_info, map: '/douban/publish_info' do
    headers "Content-Type" => 'text/javascript'
    broadcast("/info/#{@api_key.access_token}", params[:info])
    ''
  end

end
