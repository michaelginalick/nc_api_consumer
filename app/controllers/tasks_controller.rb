class TasksController < ApplicationController
	require 'rest_client'

	def index

    response = "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos.json?api_token="+session[:api_token]
    a = RestClient.get response, :Content_type => 'application/json'	

    p a

    @todos = JSON.parse(a)

    p @todos
  	end

	def edit
		@id = params["id"]
	end

	def update

		 #p params
		 task_id = params["id"]

		 p params["is_complete"].to_i

		 params["is_complete"].to_i == 1
		 	 p todo = {"todo" => {"description" => "Updated description", "is_complete" => true}}
		 	  api_token = {"api_token" => session[:api_token] }
		 	 p data = api_token.merge(todo)
		 	  p data 
		      put = RestClient.put "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos/"+task_id, data, :Content_type => 'application/json'
		 
		 	  redirect_to tasks_path
	end

	def new
		
	end

	def create
		todo = params.to_hash
		api_token = {"api_token" => session[:api_token] }
		
		payload = todo.merge(api_token)
		
		payload
		payload["api_token"]
		api_token = {"api_token" => session[:api_token] }
		payload["description"]

		request = {"api_token" => payload["api_token"], "todo" => {"description" => payload["description"]}}.to_json


		post = RestClient.post "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos", request, :Content_type => 'application/json'


		redirect_to tasks_path
	end

end
