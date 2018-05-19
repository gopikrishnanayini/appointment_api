class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]


  # get localhost:3000/doctors 
  def index
    @doctors = Doctor.all 
    render json: @doctors
  end

 #get localhost:3000/doctors/1 
  def show
    render json: @doctor
  end

  #post method localhost:3000/doctors?name=gopi&number=8121255525 
  def create
    @doctor = Doctor.new 
    @doctor.name = params[:name]
    @doctor.number =  params[:number]
    if @doctor.save
      render json: @doctor, status: :created, location: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end
 
  #put localhost:3000/doctors/1?name=gopi&number=8121255525 
  def update
    @doctor.name = params[:name]
    @doctor.number =  params[:number]
    if @doctor.save
      render json: @doctor, status: :updated, location: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  #delete localhost:3000/doctors/1 
  def destroy
    @doctor.destroy
  end

  private
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end
end
