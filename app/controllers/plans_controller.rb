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
        @new_contact = Contact.create(name: params[:contact][:new_contact_name])
        @plan.contacts << @new_contact
        current_user.contacts << @new_contact
      end
      current_user.plans << @plan
      redirect "/plans/#{@plan.id}"
    end
  end

  get '/plans/:id/edit' do
    @plan = Plan.find_by_id(params[:id])
    if logged_in? && @plan.user == current_user
      erb :'plans/edit'
    else
      redirect '/users/login'
    end
  end

  patch '/plans/:id' do
    @plan = Plan.find_by_id(params[:id])

    if params[:name].empty?
      flash[:message] = "Please enter a name for this plan."
      redirect "/plans/#{@plan.id}/edit"
    elsif Plan.find_by(name: params[:name]) && @plan.name != params[:name]
      flash[:message] = "You already have a plan with that name.<br>Please provide a different name for this plan."
      redirect "/plans/#{@plan.id}/edit"
    elsif current_user.contacts.include?(Contact.find_by(name: params[:contact][:new_contact_name]))
      flash[:message] = "You already have an existing contact with that name.<br>Please choose this contact from the contacts checklist."
      redirect "/plans/#{@plan.id}/edit"
    else
      params.delete_if {|k, v| v == ""}
      @plan.update(name: params[:name], date: params[:date], time: params[:time], location: params[:location], context: params[:context], pre_notes: params[:pre_notes], post_notes: params[:post_notes])

      if params[:contact][:existing_contacts] == nil
        @plan.contacts.clear
      else
        @plan.contacts.each do |contact|
          @plan.contacts.delete(contact) if !params[:contact][:existing_contacts].include?(contact.name)
        end
        params[:contact][:existing_contacts].each do |name|
          contact = Contact.find_by(name: name)
          @plan.contacts << contact unless @plan.contacts.include?(contact)
        end
      end

      unless params[:contact][:new_contact_name].empty?
        @new_contact = Contact.create(name: params[:contact][:new_contact_name])
        @plan.contacts << @new_contact
        current_user.contacts << @new_contact
      end

      redirect "/plans/#{@plan.id}"
    end
  end

  get '/plans/:id' do
    @plan = Plan.find_by_id(params[:id])
    if logged_in? && @plan.user == current_user
      erb :'plans/show'
    else
      redirect '/users/login'
    end
  end

  get '/plans/:id/delete' do
    @plan = Plan.find_by_id(params[:id])
    if logged_in? && current_user == @plan.user
      erb :'plans/delete'
    else
      redirect '/users/login'
    end
  end

  delete '/plans/:id' do
    @plan = Plan.find_by_id(params[:id])

    @plan.delete
    flash[:message] = "Plan has been deleted successfully."
    redirect '/plans'
  end

  helpers do
    def plan_with_no_info?(plan)
      if !plan.date && !plan.time && !plan.location && !plan.context && !plan.pre_notes && !plan.post_notes && plan.contacts.empty?
        true
      else
        false
      end
    end
  end
end
