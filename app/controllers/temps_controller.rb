class TempsController < ApplicationController
  before_action :set_project
  before_action :set_temp, only: [:show, :update, :destroy]

  # GET /projects/:project_id/temps
  def index
    json_response(@project.temps)
  end

  # GET /projects/:project_id/temps/:id
  def show
    json_response(@temp)
  end

  # POST /projects/:project_id/temps
  def create
    temp = @project.temps.create!(temp_params)
    json_response(temp, :created)
  end

  # PUT /projects/:project_id/temps/:id
  def update
    @temp.update(temp_params)
    head :no_content
  end

  # DELETE /projects/:project_id/temps/:id
  def destroy
    @temp.destroy
    head :no_content
  end

  private

  def temp_params
    params.permit(:value)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_temp
    @temp = @project.temps.find_by!(id: params[:id]) if @project
  end
end
