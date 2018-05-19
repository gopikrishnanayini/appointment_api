class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :update, :destroy]

  #get localhost:3000/appointments
  def index
    @appointments = Appointment.all
    render json: @appointments
  end
 
 #get localhost:3000/appointments/1
  def show
    render json: @appointment
  end

 # post localhost:3000/appointments?doctor=doctor&patient=patient&disease=disease 
  def create
    @appointment = Appointment.new 
    @appointment.doctor = params[:doctor]
    @appointment.patient =  params[:patient]
    @appointment.disease =  params[:disease]
    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  #put localhost:3000/appointments/1?doctor=doctor&patient=patient&disease=disease
  def update
    @appointment.doctor = params[:doctor]
    @appointment.patient =  params[:patient]
    @appointment.disease =  params[:disease]
    if @appointment.save
      render json: @appointment, status: :updated, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end


  # delete localhost:3000/appointments/1
  def destroy
    @appointment.destroy
  end

  private
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end
end
