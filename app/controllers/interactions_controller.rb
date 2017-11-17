class InteractionsController < ApplicationController

  get '/interactions/new' do
    if logged_in?
      erb :'interactions/new'
    else
      redirect '/users/login'
    end
  end

  get '/interactions/new/:id' do # for cases when a user is adding a new interaction on a specific contact from the 'contact/show' view
    @contact = Contact.find_by_id(params[:id])
    if logged_in? && current_user.id == @contact.user_id
      erb :'interactions/new'
    else
      redirect '/users/login'
    end
  end

  post '/interactions' do
    if !params.key?("contact_name") && params[:new_contact_name].empty?
      flash[:message] = "Please provide a contact name for this interaction."
      redirect '/interactions/new'
    elsif params.key?("contact_name") && !params[:new_contact_name].empty?
      flash[:message] = "Please provide only one contact name for this interaction."
      redirect '/interactions/new'
    elsif params[:date] == "" || params[:details] == ""
      flash[:message] = "Please fill in all of the necessary information below."
      redirect '/interactions/new'
    elsif current_user.contacts.find_by(name: params[:new_contact_name])
      flash[:message] = "You already have an existing contact with that name.<br>Please try again or choose the existing contact below."
      redirect '/interactions/new'
    else
      @interaction = LastInteraction.create(date: params[:date], details: params[:details])
      if @contact = Contact.find_by(name: params[:contact_name])
        @contact.last_interactions << @interaction
      else
        @contact = Contact.create(name: params[:new_contact_name])
        @contact.last_interactions << @interaction
      end
      current_user.contacts << @contact
      redirect "/users/home"
    end
  end

  get '/interactions/:id' do
    @interaction = LastInteraction.find_by_id(params[:id])
    if logged_in? && current_user.id == @interaction.contact.user_id
      erb :'interactions/show'
    else
      redirect '/users/home'
    end
  end
end
