class EncountersController < ApplicationController
  before_action :authenticate_user!

  def new
    @encounter = Encounter.new
    @encounters = current_user.encounters
  end

  def index
    # if there are the start_date and end_date params
      # report = Report.new(pass in the params)
      # @encounters = report.encounters
    # else
      @encounter = Encounter.new
      @grouped_encounters = current_user.encounters.group_by_day(:created_at).count
      if params[:date]
        date = Date.parse(params[:date])
        @encounters = current_user.encounters.where(created_at: date.beginning_of_day..date.end_of_day)
      else
        @encounters = current_user.encounters
      end
    # end
  end

  def create
    @encounter = Encounter.new(encounter_params)
    # @encounter.includes([:user, :procedure]).where(user: current_user)
    @encounter.user_id = current_user.id
    @encounter.set_physician_fee

    respond_to do |format|
      if @encounter.save
        format.js
      end
    end
  end

  def destroy
    @encounter = Encounter.find(params[:id])
    @encounter.destroy
    respond_to do |format|
      format.js {render status: 200, json: {name: 'good job'}}
    end
  end

  def show
    @encounter = Encounter.find(params[:id])
  end

  protected
  def encounter_params
    params.require(:encounter).permit(:patient_name, :insurance_provider, :notes, :procedure_id).merge(user: current_user)
  end
end
