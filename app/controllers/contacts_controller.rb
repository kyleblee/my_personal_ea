class ContactsController < ApplicationController

  get '/contacts' do
    if logged_in?
      erb :'contacts/index'
    else
      redirect '/users/login'
    end
  end
end
