class TasksController < ApplicationController
	require 'rest_client'

	def index

    response = "http://recruiting-api.nextcapital.com/users/"+session[:user_id].to_s+"/todos.json?api_token="+session[:api_token]
    a = RestClient.get response, :Content_type => 'application/json'	

    @todos = JSON.parse(a)

    p @todos

    p @todos[0][:id]
    
	end

	def edit
	end

	def new
		#session[:user_id] =  h["id"]
	end

	def create
		todo = params.to_hash
		session[:user_id]
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
