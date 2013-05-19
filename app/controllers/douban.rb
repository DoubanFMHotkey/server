DoubanFmHotkeyServer::App.controllers :douban do

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
