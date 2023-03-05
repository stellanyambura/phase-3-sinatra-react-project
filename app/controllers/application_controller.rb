require 'sinatra'
require 'json'
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
# Define a route to get all projects for a user
get '/users' do
  content_type :json
  users = User.all
  users.to_json
end

# sign up
post '/add/user' do
  # create a new user
  user = User.create(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    password_digest: params[:password_digest]
  )
end

end