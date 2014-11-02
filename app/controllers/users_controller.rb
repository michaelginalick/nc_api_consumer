class UsersController < ApplicationController
 require 'rest_client'

 	#goes to create_user_path   post '/users/create' => 'users#user_create', :as => 'create_user'
  def index
    #    begin
    #   payload = params.to_json
    #   post = RestClient.post 'http://recruiting-api.nextcapital.com/users', payload, :Content_type => 'application/json'
    # rescue => e
    #   response_code = e.response.code
    #     if response_code == 400
    #        flash[:notice] = "Please choose another email."
    #        redirect_to root_path
    #     else
    #        todo = JSON.parse(post.body)
    #        p session[:user_id] =  todo["id"]
    #        p session[:api_token] = todo["api_token"]
    #        p session[:todos] =  todo["todos"]
    #     end
    # end

  end

  

 def sign_in
     begin
     	payload = params.to_json
      post = RestClient.post 'http://recruiting-api.nextcapital.com/users/sign_in', payload, :Content_type => 'application/json'
     rescue => e
      p "******sign_in*************"
        p response_code = e.response.code
        p response_code = e.response.body
          if response_code == 400
              flash[:notice] = "Invalid email/password. Please try again."
              redirect_to root_path and return
         else
              redirect_to tasks_path
         end    
      end           
  end

  def user_create
    begin
  	  payload = params.to_json
      post = RestClient.post 'http://recruiting-api.nextcapital.com/users', payload, :Content_type => 'application/json'
    rescue => e
      response_code = e.response.code
        if response_code == 400
           flash[:notice] = "Please choose another email."
           redirect_to root_path and return
        end
    end
      todo = JSON.parse(post.body)
      session[:user_id] =  todo["id"]
      session[:api_token] = todo["api_token"]
      session[:todos] =  todo["todos"]
      redirect_to log_in_path
  end

  def log_in
     begin
        payload = params.to_json
          post = RestClient.post 'http://recruiting-api.nextcapital.com/users/sign_in', payload, :Content_type => 'application/json'
       rescue => e
           response_code = e.response.code
            if response_code == 400
                 flash[:notice] = "Invalid email/password. Please try again."
                 redirect_to root_path and return
              end
         end  
         redirect_to tasks_path
         
    end


  # def show
  # end

end
