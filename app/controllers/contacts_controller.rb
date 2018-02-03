class ContactsController < ApplicationController

  get '/contacts' do
    if logged_in?
      erb :'contacts/index'
    else
      redirect '/users/login'
    end
  end

  get '/contacts/new' do
    if logged_in?
      erb :'contacts/new'
    else
      redirect '/users/login'
    end
  end

  post '/contacts' do
    authenticate_user
    if params[:name] == ""
      flash[:message] = "Please enter a name for the new contact."
      redirect '/contacts/new'
    elsif Contact.find_by(name: params[:name])
      flash[:message] = "A contact already has that name. <br>Try including a last name so they don't get mixed up."
      redirect '/contacts/new'
    else
      if valid_email?(params) || params[:email] == ""
        params.delete_if {|key, value| value == ""}
        @contact = Contact.create(name: params[:name], location: params[:location], email: params[:email], phone_number: params[:phone_number], category: params[:category], expertise: params[:expertise], preferences: params[:preferences])
        current_user.contacts << @contact
        redirect "/contacts/#{@contact.id}"
      else
        flash[:message] = "That email doesn't seem to be valid."
        redirect '/contacts/new'
      end
    end
  end

  get '/contacts/:id/edit' do
    authenticate_user
    @contact = Contact.find_by(id: params[:id])
    if @contact && @contact.user == current_user
      erb :'contacts/edit'
    else
      redirect '/contacts'
    end
  end

  patch '/contacts/:id' do
    @contact = Contact.find_by_id(params[:id])
    if params[:name] == ""
      flash[:message] = "Please enter a name for the updated contact."
      redirect "/contacts/#{@contact.id}/edit"
    elsif Contact.find_by(name: params[:name]) && @contact.name != params[:name]
      flash[:message] = "A contact already has that name. <br>Try including a last name so they don't get mixed up."
      redirect "/contacts/#{@contact.id}/edit"
    else
      if valid_email?(params) || params[:email] == ""
        params.delete_if {|key, value| value == ""}
        @contact.update(name: params[:name], location: params[:location], email: params[:email], phone_number: params[:phone_number], category: params[:category], expertise: params[:expertise], preferences: params[:preferences])
        redirect "/contacts/#{@contact.id}"
      else
        flash[:message] = "That email doesn't seem to be valid."
        redirect "/contacts/#{@contact.id}/edit"
      end
    end
  end

  get '/contacts/:id/delete' do
    @contact = Contact.find_by_id(params[:id])
    if logged_in? && current_user.id == @contact.user_id
      erb :'contacts/delete'
    else
      redirect '/users/login'
    end
  end

  delete '/contacts/:id' do
    @contact = Contact.find_by_id(params[:id])
    flash[:message] = "#{@contact.name} has been deleted from your contacts."
    @contact.delete
    redirect '/contacts'
  end

  get '/contacts/:id' do
    @contact = Contact.find_by_id(params[:id])
    @ordered_interactions = @contact.last_interactions.sort_by {|interaction| interaction.id}.reverse
    if logged_in? && @contact.user_id == current_user.id
      erb :'contacts/show'
    else
      redirect '/users/login'
    end
  end
end
