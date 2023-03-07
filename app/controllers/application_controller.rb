require 'sinatra'
require 'json'
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Define a route to get all projects for a user
  get '/users' do
    content_type :json
    users = User.all
    users.to_json(include: [:projects, :skills])
  end

  # sign up
  post '/add/user' do
    # create a new user
    user = User.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password]
    )
    user.save
  end

  post "/login" do
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]
      content_type :json
      { success: true, message: "Login successful" }.to_json
    else
      content_type :json
      status 401 # unauthorized
      { error: "Invalid email or password." }.to_json 
    end
   end

# user's dashboard
get "/user/:email" do
  user = User.find_by(email: params[:email])
  user.to_json(include: [:projects, :skills])
  end
  
  # route for adding new skills
  post '/add/skill/:id' do
    skill = Skill.new(
      name: params[:name],
      description: params[:description],
      user_id: params[:id]
    )
    skill.save
  end
  
  # route for updating user skills
  put "/skills/:id/:skill_id" do
    skills = User.find(params[:id]).skills.find(params[:skill_id])# Find the user by id
    skills.update(name: params[:name], description: params[:description]) # Update the user's name and email
  end
  
  # route for deleting a skill
  delete '/destroy/skills/:id/:skill_id' do
    user = User.find(params[:id]).skills.find_by(id: params[:skill_id])# Find the user by id
    user.destroy
  end
  
  # addign a new project
  post '/add/projects/:id' do
    project = Project.create(
      title: params[:title],
      description: params[:description],
      project_Github_url: params[:project_Github_url],
      user_id: params[:id]
    )
  end
  
  # Define a route to update an existing project for a user
  put '/users/:id/projects/:project_id' do
    project = User.find(params[:id]).projects.find(params[:project_id])
    project.update(title: params[:title], description: params[:description], project_Github_url: params[:github_url])
  end
  
  # delete a project
  delete '/users/:id/projects/:project_id' do
    project = User.find(params[:id]).projects.find(params[:project_id])
    project.destroy
  end
end