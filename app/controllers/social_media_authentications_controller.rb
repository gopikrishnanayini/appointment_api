class SocialMediaAuthenticationsController < ApplicationController

  skip_before_action :verify_authenticity_token  
  respond_to :json

  def create
    provider = params[:provider]
    email = params[:email]
    if provider.present? 
      if provider == 'facebook' and params['facebook_id'].blank?
        render :status => 200,:json => {:status=>"Failure",:message=>"Provide Facebook Id."}
        return   
      elsif provider == 'google+' and params['google_id'].blank?
        render :status => 200,:json => {:status=>"Failure",:message=>"Provide Google Id."}
        return
      end        
    else
      render :status=>200, :json=>{:status=>"Failure", :message=>"The request must contain provider or event."}
      return
    end

    if user.present?
      if user.errors.present?
        render :status => 200,:json => {:status=>"Failure",:message=>"You need to pass these values: #{user.errors.full_messages.join(" , ")}"}
        return
      else  
        render :status=>200, :json=>{:status=>"Success",:secret_key=>user.secret_key,:key=>user.key}
        return
      end  
    else
    	render :status=>200, :json=>{:status=>"Failure",:message=>"User Not Found."}
      return	
    end
  end
end