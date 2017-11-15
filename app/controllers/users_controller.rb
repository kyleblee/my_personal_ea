class UsersController < ApplicationController

  get '/users/signup' do
    if logged_in?
      redirect '/users/home'
    else
      erb :'users/signup'
    end
  end

  get '/users/login' do
    if logged_in?
      redirect '/users/home'
    else
      erb :'users/login'
    end
  end

  post '/users/login' do
    if params.value?("")
      flash[:message] = "Please enter both username and password."
      redirect '/users/login'
    elsif @user = User.find_by(username: params[:username])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect '/users/home'
      else
        flash[:message] = "Incorrect password. Please try again."
        redirect '/users/login'
      end
    else
      flash[:message] = "No user found with that username. Please try again or <a href='/users/signup'>sign up here</a>."
      redirect '/users/login'
    end

  end

  post '/users' do
    if params.value?("")
      flash[:message] = "Please fill out all of the form."
      redirect '/users/signup'
    elsif !valid_email?(params)
      flash[:message] = "Please enter a valid email."
      redirect '/users/signup'
    elsif username_taken?(params)
      flash[:message] = "Username taken. Please try something else."
      redirect '/users/signup'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      if @user
        session[:user_id] = @user.id
        flash[:message] = "Welcome to My Personal EA, #{@user.username}!"
        redirect '/users/home'
      else
        flash[:message] = "Something went wrong. Please try again."
        redirect '/users/signup'
      end
    end
  end

  get '/users/home' do
    if logged_in?
      @user = current_user
      @ordered_interactions = @user.last_interactions.sort_by {|interaction| interaction.id}.reverse
      erb :'users/index'
    end
  end

  get '/users/logout' do
    session.clear if logged_in?
    redirect '/users/login'
  end


  helpers do
    def username_taken?(params)
      User.all.detect {|user| params[:username] == user.username}
    end

    def valid_email?(params)
      params[:email] =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    end
  end
end
