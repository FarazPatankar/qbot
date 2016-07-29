class SlackApiController < ApplicationController
	def handle_message

		puts params.inspect

		render:json => "Hello"
	end
end
