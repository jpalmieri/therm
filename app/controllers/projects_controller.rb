class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = current_user.projects
    json_response(@projects)
  end

  # GET /projects/:id
  def show
    json_response(@project)
  end

  # POST /projects
  def create
    @project = current_user.projects.create!(project_params)
    json_response(@project, :created)
  end

  # PUT /projects/:id
  def update
    @project.update(project_params)
    head :no_content
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def project_params
    params.permit(:name, :description)
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end
end
