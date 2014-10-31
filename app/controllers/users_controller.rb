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
    
    user_id =  h["id"]
    api_token = h["api_token"]
   

    	
    get = "http://recruiting-api.nextcapital.com/users/"+user_id.to_s+"/todos.json?api_token="+api_token


    RestClient.get get, :Content_type => 'application/json'	

     todo = JSON.parse(post.body)
     @user_id =  todo["id"]
     @api_token = todo["api_token"]
     @todos =  todo["todos"]

    redirect_to user_tasks_path(user_id)

  end

  def user_create

  	payload = params.to_json
    #post = RestClient.post 'http://recruiting-api.nextcapital.com/users', {:email => 'red12345@gmail.com', :password => 'tester1234'}.to_json, :Content_type => 'application/json'
    post = RestClient.post 'http://recruiting-api.nextcapital.com/users', payload, :Content_type => 'application/json'

    p todo = JSON.parse(post.body)
    p @user_id =  todo["id"]
    p @api_token = todo["api_token"]
    p @todos =  todo["todos"]
  
  end


  def show
  end

  def destroy

    data = {"api_token" => "HkpxtouBC5d7PwJnp8XP", "user_id" => 471}
    d = data.to_json

  	RestClient.delete 'http://recruiting-api.nextcapital.com/users/sign_out', d, :Content_type => 'application/json'
  	
  	redirect_to root_path

  end



end
