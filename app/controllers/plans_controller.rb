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

  post '/plans' do
    if params[:name].empty?
      flash[:message] = "Please enter a name for this plan."
      redirect '/plans/new'
    elsif Plan.find_by(name: params[:name]) && Plan.find_by(name: params[:name]).user == current_user
      flash[:message] = "You already have a plan with that name.<br>Please provide a different name for this new plan."
      redirect '/plans/new'
    elsif Contact.find_by(name: params[:contact][:new_contact_name]) && Contact.find_by(name: params[:contact][:new_contact_name]).user_id == current_user.id
      flash[:message] = "You already have an existing contact with that name.<br>Please choose this contact from the contacts checklist."
      redirect '/plans/new'
    else
      params.delete_if {|k, v| v == ""}
      @plan = Plan.create(name: params[:name], date: params[:date], time: params[:time], location: params[:location], context: params[:context], pre_notes: params[:pre_notes], post_notes: params[:post_notes])
      unless params[:contact][:existing_contacts] == nil
        params[:contact][:existing_contacts].each {|name| @plan.contacts << Contact.find_by(name: name)}
      end
      unless params[:contact][:new_contact_name].empty?
        @plan.contacts << Contact.create(name: params[:contact][:new_contact_name])
      end
      current_user.plans << @plan
      redirect "/plans/#{@plan.id}"
    end
  end

  get '/plans/:id' do
    @plan = Plan.find_by_id(params[:id])
    binding.pry
  end
end
