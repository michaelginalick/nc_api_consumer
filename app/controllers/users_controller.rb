class UsersController < ApplicationController
 require 'rest_client'

 	#goes to create_user_path   post '/users/create' => 'users#user_create', :as => 'create_user'
  def index
 

  end

  

  def sign_in
 
  	payload = params.to_json
    post = RestClient.post 'http://recruiting-api.nextcapital.com/users/sign_in', payload, :Content_type => 'application/json'
    #p "***********************"
    h = JSON.parse(post.body)
    #p "***********************"
    
    session[:user_id] =  h["id"]
    session[:api_token] = h["api_token"]
   

    	
    get = "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos.json?api_token="+session[:api_token]


    RestClient.get get, :Content_type => 'application/json'	

     todo = JSON.parse(post.body)
     session[:user_id] =  todo["id"]
     session[:api_token] = todo["api_token"]
     #session[:todos] =  todo["todos"]
     @todo = todo["todos"]

    redirect_to tasks_path

  end

  def user_create

  	payload = params.to_json
    post = RestClient.post 'http://recruiting-api.nextcapital.com/users', payload, :Content_type => 'application/json'

    todo = JSON.parse(post.body)
    session[:user_id] =  todo["id"]
    session[:api_token] = todo["api_token"]
    session[:todos] =  todo["todos"]
  
  end


  def show
  end

end
