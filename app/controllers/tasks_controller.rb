class TasksController < ApplicationController
	require 'rest_client'

	def index
		 begin
     	  a = RestClient.get "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos.json?api_token="+session[:api_token], :Content_type => 'application/json'
     	  rescue => e	
     		 response_code = e.response.code
	          	if response_code == 400
	              	flash[:notice] = "Something went wrong. Please try again"
	              	redirect_to root_path and return
	            end  	
	  	 end
    	@todos = JSON.parse(a)
  	end

	def edit
		@id = params["id"]
	end

	def update
		 task_id = params["id"]
		 
		 if params["is_complete"].to_i == 1
		 	todo = {"todo" => {"description" => "Updated description", "is_complete" => true}}
		 	api_token = {"api_token" => session[:api_token] }
		 	data = api_token.merge(todo)
		 	put = RestClient.put "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos/"+task_id, data, :Content_type => 'application/json'
		 	redirect_to tasks_path
		 else
		 	redirect_to tasks_path
		 end
	end

	def new
		
	end

	def create
		todo = params.to_hash
		api_token = {"api_token" => session[:api_token] }
		payload = todo.merge(api_token)
		payload["api_token"]
		api_token = {"api_token" => session[:api_token] }
		request = {"api_token" => payload["api_token"], "todo" => {"description" => payload["description"]}}.to_json
		post = RestClient.post "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos", request, :Content_type => 'application/json'
		redirect_to tasks_path
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
end
