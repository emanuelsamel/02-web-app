
require_relative 'contact'
require 'sinatra'
require 'sinatra/reloader'
get "/"do
erb :home
end
get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/about" do
  erb :about
end

get "/contacts/new" do
  erb :Add_contact
end

get "/contacts/:id" do

  @contact = Contact.find_by(id: params[:id])
  if
    @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

post "/contacts" do
  Contact.create(
  first_name: params[:first_name],
  last_name:  params[:last_name],
  email:      params[:email],
  note:       params[:note]
  )
  redirect "/contacts"
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

delete '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end


# require_relative 'contact.rb'
#
# class CRM
#
#   def initialize#(name)
#     # @name = name
#     # puts "This CRM has the name " + @name
#   end
#
#   def main_menu
#     while true # repeat indefinitely
#       print_main_menu
#       user_selected = gets.to_i
#       call_option(user_selected)
#     end
#   end
#
#   def print_main_menu
#     puts '[1] Add a new contact'
#     puts '[2] Modify an existing contact'
#     puts '[3] Delete a contact'
#     puts '[4] Display all the contacts'
#     puts '[5] Search by attribute'
#     puts '[6] Exit'
#     puts 'Enter a number: '
#   end
#
#   def call_option(user_selected)
#     case user_selected
#       when 1 then add_new_contact
#       when 2 then modify_existing_contact
#       when 3 then delete_contact
#       when 4 then display_all_contacts
#       when 5 then search_by_attribute
#       when 6 then exit
#     end
#   end
#
#   def add_new_contact
#     print 'Enter First Name: '
#     first_name = gets.chomp
#
#     print 'Enter Last Name: '
#     last_name = gets.chomp
#
#     print 'Enter Email Address: '
#     email = gets.chomp
#
#     print 'Enter a Notes: '
#     note = gets.chomp
#
#     contact = Contact.create(
#       first_name: first_name,
#       last_name:  last_name,
#       email:      email,
#       note:       note
#     )
#
#   end
#
#
#   def modify_existing_contact
#
#     print "What's the first name of the contact you would like to modify?"
#     value_find = gets.chomp
#
#     contact_to_modify = Contact.find_by("first_name", value_find)
#
#     print 'Enter the attribute you would like to modify: '
#     attribute = gets.chomp
#
#     print 'Enter the new value for that attribute: '
#     value = gets.chomp
#
#     contact_to_modify.update(attribute, value)
#   end
#
#   def delete_contact
#     print "What's the first name of the contact you would like to delete?"
#     value_delete = gets.chomp
#     contact_to_delete = Contact.find_by("first_name", value_delete)
#
#     print 'Deleting contact...'
#     contact_to_delete.delete
#   end
#
#   def display_all_contacts
#     print 'Displaying all contacts...'
#     Contact.all.each do |contact|
#       puts "#{contact.first_name} #{contact.last_name} #{contact.email} #{contact.notes}"
#     end
#   end
#
#   def search_by_attribute
#     print 'Enter the attribute you would like to search for: '
#     attritube = gets.chomp
#
#     print 'Enter the value for that attribute: '
#     value = gets.chomp
#
#     Contact.find_by(attribute, value)
#   end
#   at_exit do
#     ActiveRecord::Base.connection.close
#   end
#
#   a_crm_app = CRM.new
#   a_crm_app.main_menu
# end
