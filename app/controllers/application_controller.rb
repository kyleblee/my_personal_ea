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
      !!current_user
    end

    def current_user #(set / getter) #=> USer Instance || nil
      # memoization
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def valid_email?(params)
      params[:email] =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    end

    def authenticate_user
      # make sure that logged_in?
      if !logged_in?
        redirect "/users/login"
      end
    end
  end
end
