include SlackApiHelper

class SlackApiController < ApplicationController
	def handle_message
		channel_id = params[:channel_id]
		channel_name = params[:channel_name]

		user_id = params[:user_id]
		user_name = params[:user_name]

		line = Line.where(channel_id: channel_id).first

		if line.nil?
			line = Line.create(channel_id: channel_id, channel_name: channel_name)
		end

		user = User.where(user_id: user_id).first

		if user.nil?
			user = User.create(user_id: user_id, user_name: user_name)
		end

		line.users.push(user)

		response = response_generator(line)

		render :json => {
						    "text": "The queue now is :",
						    "attachments": [
						        {
						            "text": response
						        }
						    ]
						}
	end
end
