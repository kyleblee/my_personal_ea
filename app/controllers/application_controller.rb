class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'my_personal_executive_assistant'
  end

  get '/' do
    "Hello World"
  end
  # enter routes here
end
