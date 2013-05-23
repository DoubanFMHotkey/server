DoubanFmHotkeyServer::App.controllers :api do

  get :index do
    render 'api/index'
  end

  post :regenerate, map: '/api/regenerate' do
    current_user.api_key.destroy
    current_user.api_key = ApiKey.new
    current_user.save
    redirect_to url_for(:api, :index)
  end

end
