class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :destroy]
  
  #get method localhost:3000/patients 
  def index
    @patients = Patient.all 
    render json: @patients
  end
  
  #get #localhost:3000/patients/1
  def show
    render json: @patient
  end

  #post localhost:3000/patients?name=gopi&number=8121255525 
  def create
    @patient = Patient.new  
    @patient.name = params[:name]
    @patient.number =  params[:number]
    if @patient.save
      render json: @patient, status: :created, location: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  #put localhost:3000/patients/1?name=gopi&number=8121255525
  def update
    @patient.name = params[:name] 
    @patient.number =  params[:number]
    if @patient.save
      render json: @patient, status: :updated, location: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  #delete #localhost:3000/patients/1
  def destroy
    @patient.destroy
  end

  private
    def set_patient
      @patient = Patient.find(params[:id])
    end
end
