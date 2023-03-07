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
  
end # added this to close the class definition
#To create a new skill, you can uase the create method of the Skill model:
def create
  skill = Skill.create(skill_params)
  if skill.valid?
    render json: skill, status: :created
  else
    render json: { error: skill.errors.full_messages }, status: :unprocessable_entity
  end
end

private

def skill_params
  params.require(:skill).permit(:name, :description, :user_id)
end
#To read a single skill, you can use the find method of the Skill model:
def show
  skill = Skill.find(params[:id])
  render json: skill
rescue ActiveRecord::RecordNotFound
  render json: { error: "Skill not found" }, status: :not_found
end
#To update an existing skill, you can use the update method of the Skill model:

def update
  skill = Skill.find(params[:id])
  if skill.update(skill_params)
    render json: skill
  else
    render json: { error: skill.errors.full_messages }, status: :unprocessable_entity
  end
rescue ActiveRecord::RecordNotFound
  render json: { error: "Skill not found" }, status: :not_found
end
#To delete a skill, you can use the destroy method of the Skill model:

def destroy
  skill = Skill.find(params[:id])
  skill.destroy
  head :no_content
rescue ActiveRecord::RecordNotFound
  render json: { error: "Skill not found" }, status: :not_found
end
def create
  project = Project.create(project_params)
  if project.valid?
    render json: project, status: :created
  else
    render json: { error: project.errors.full_messages }, status: :unprocessable_entity
  end
end
def project_params
  params.require(:project).permit(:title, :description, :image_url, :project_status, :project_Github_url, :user_id)
end
def show
  project = Project.find(params[:id])
  render json: project
rescue ActiveRecord::RecordNotFound
  render json: { error: "Project not found" }, status: :not_found
end
def update
  project = Project.find(params[:id])
  if project.update(project_params)
    render json: project
  else
    render json: { error: project.errors.full_messages }, status: :unprocessable_entity
  end
rescue ActiveRecord::RecordNotFound
  render json: { error: "Project not found" }, status: :not_found
end
def destroy
  project = Project.find(params[:id])
  project.destroy
  head :no_content
rescue ActiveRecord::RecordNotFound
  render json: { error: "Project not found" }, status: :not_found
end
get '/projects' do
  project = Project.all
  project.to_json
end

 
# addign a new project
post '/add/projects/:id' do
  project = Project.create(
    title: params[:title],
    description: params[:description],
    project_Github_url: params[:Github_url],
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