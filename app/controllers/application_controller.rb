class ApplicationController < Sinatra::Base
  configure do
    register Sinatra::ActiveRecordExtension
    set :public_folder, 'public'
    use Rack::Flash
    enable :sessions
    set :session_secret, 'my_personal_executive_assistant'
    set :views, 'app/views'
  end

  get '/' do
    if logged_in?
      redirect '/users/home'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
