class UsersController < ApplicationController
  
	before_action :set_instances_for_get_key, :check_user_presence_for_get_key, :only => [:log_in]
	before_action :set_user, only: [:show, :update, :destroy]
  respond_to :json

  #get localhost:3000/users 
  def index
    @users = User.all 

    render json: @users
  end

  #post localhost:3000/users/log_in?email=nayinig@mail.com&password=password 
  def log_in 
    if @user.present? and not (@user.encrypted_password == BCrypt::Engine.hash_secret(@password, @user.salt))
      render :status=>200, :json=>{:status=>"Failure",:message=>"Invalid password."} and return
    else
      if @user.present?
        @user.save
        render :staus => 200, :json => {:status => "Success",:secret_key=>@user.secret_key,:key=>@user.key } and return
      else
        render :status => 200, :json => {:status => "Failure", :message => "User Not Found."}
      end 
    end
  end

  #post localhost:3000/users/log_in?email=nayinii1@mail.com&password=password
  def create
    @user = User.new  
    @user.email = params[:email]
    @user.password =  params[:password]
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  #get localhost:3000/users/1
  def show
    render json: @user
  end

  #localhost:3000/users/1?email=gopi@mail.com&password=password put method api
  # def update
  #   @user.email = params[:email]
  #   @user.password =  params[:password]
  #   if @user.save
  #     render json: @user, status: :updated, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  #delete localhost:3000/users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_instances_for_get_key
    @user = User.find_by_email(params[:email].downcase) rescue nil 
  end

  def check_user_presence_for_get_key
    @email, @password = params[:email], params[:password]
    if @email.blank? or @password.blank?
      if request.format == :json
        render :status=>200,:json=>{:status=>"Failure",:message=>"The request must contain the email and password."} and return
      else
        @status = 'Invalid Username or Password' and return
      end
    end
    if @user.nil?
      logger.info("User #{@email} failed signin, user cannot be found.")
      if request.format == :json
        render :status=>200, :json=>{:status=>"Failure",:message=>"Invalid email"} and return
      else
        @status = 'Invalid Username or Password'
      end
    end
  end
end
