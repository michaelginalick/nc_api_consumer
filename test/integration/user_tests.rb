require 'test_helper'
require 'rest_client'

class UserTests < ActionDispatch::IntegrationTest

	setup {host! 'http://recruiting-api.nextcapital.com'}
	test 'ensures that the site will send a response' do
		get 'http://recruiting-api.nextcapital.com'
		assert_equal 200, response.status
		refute_empty response.body
	end

	test 'ensures that the site will send a response' do
	get '/users/sign_in'
	assert_equal 200, response.status
	refute_empty response.status

end
