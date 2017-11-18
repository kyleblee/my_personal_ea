class PlansController < ApplicationController

  get '/plans' do
    if logged_in?
      erb :'plans/index'
    else
      redirect '/users/home'
    end
  end

  get '/plans/new' do
    if logged_in?
      erb :'plans/new'
    else
      redirect '/plans'
    end
  end
end
