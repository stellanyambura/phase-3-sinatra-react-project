require 'sinatra'
require 'json'

# Define a route to get all projects for a user
class ApplicationController < Sinatra::Base
get '/users/:id/projects' do
  content_type :json
  user_id = params[:id]
  # Retrieve all projects for the given user from the database
  projects = Project.where(user_id: user_id)
  # Return the projects as JSON
  projects.to_json
end
get '/users' do 
  users = User.all
  users.to_json
end
# create a new user in the database
post '/add/user' do
  # check if email already exists in database
  if User.find_by(email: params[:email])
    return "Error: Email already exists"
  end
  # create a new user
  user = User.new(
    first_name: params[:first_name],
    last_name: params[:last_name],
    email: params[:email],
    password: params[:password]
  )
  user.save
end
  # # check if email already exists in database
  # if User.find_by(email: params[:email])
  #   return "Error: Email already exists"
  # end
# Define a route to create a new project for a user
post '/users/:id/projects' do
  content_type :json
  user_id = params[:id]
  project = Project.new(params[:project])
  project.user_id = user_id
  # Save the project to the database
  if project.save
    # Return the new project as JSON
    project.to_json
  else
    # Return an error message as JSON
    { error: 'Failed to create project' }.to_json
  end
end

# Define a route to update an existing project for a user
put '/users/:id/projects/:project_id' do
  content_type :json
  user_id = params[:id]
  project_id = params[:project_id]
  project = Project.where(user_id: user_id, id: project_id).first
  if project
    # Update the project attributes
    project.update_attributes(params[:project])
    # Return the updated project as JSON
    project.to_json
  else
    # Return an error message as JSON
    { error: 'Project not found' }.to_json
  end
end

# Define a route to delete a project for a user
delete '/users/:id/projects/:project_id' do
  content_type :json
  user_id = params[:id]
  project_id = params[:project_id]
  project = Project.where(user_id: user_id, id: project_id).first
  if project
    # Delete the project from the database
    project.destroy
    # Return a success message as JSON
    { message: 'Project deleted successfully' }.to_json
  else
    # Return an error message as JSON
    { error: 'Project not found' }.to_json
  end
end
end