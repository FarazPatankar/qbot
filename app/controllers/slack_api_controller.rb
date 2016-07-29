include SlackApiHelper

class SlackApiController < ApplicationController
	def handle_message
		channel_id = params[:channel_id]
		channel_name = params[:channel_name]

		user_id = params[:user_id]
		user_name = params[:user_name]

		text = params[:text]

		if text == "help"

			if line.nil?
				line = Line.create(channel_id: channel_id, channel_name: channel_name)
			end

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
		elsif text == "view"
			line = Line.where(channel_id: channel_id).first

			if line.nil?
				line = Line.create(channel_id: channel_id, channel_name: channel_name)
			end

			response = response_generator(line)

			render :json => {
							    "text": "The queue now is :",
							    "attachments": [
							        {
							            "text": response.empty? ? "EMPTY" : response
							        }
							    ]
							}

		elsif text == "pop"
			line = Line.where(channel_id: channel_id).first

			if line.users.count > 0
				popped_user = line.users.first.user_name

				line.users.first.destroy

				response = response_generator(line)

				render :json => {
							    "text": "You popped the user - #{popped_user}. The queue now is :",
							    "attachments": [
							        {
							            "text": response.empty? ? "EMPTY" : response
							        }
							    ]
							}
			else
				render :json => "There's nothing to pop, son!"
			end

		else
			render :json => "I don't get it. Perhaps you should check the documentation, son."
		end
	end
end
