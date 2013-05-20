DoubanFmHotkeyServer::App.controllers :auth do

  get :auth_callback, map: '/auth/douban/callback' do
    auth = env['omniauth.auth']
    user = User.find_or_create_by_auth(auth)
    session[:user] = user.id
    redirect_to url_for(:home, :index)
  end

  get :auth_failure, map: '/auth/failure' do
    'auth failure'
  end

end
