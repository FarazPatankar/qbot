include SlackApiHelper

class SlackApiController < ApplicationController
	def handle_message
		channel_id = params[:channel_id]
		channel_name = params[:channel_name]

		user_id = params[:user_id]
		user_name = params[:user_name]

		text = params[:text]

		poppers_array = ENV['poppers'].split("\n")

		if text == "help"
			line = find_or_create_line(channel_id, channel_name)
			user = find_or_create_user(user_id, user_name)

			line.users.push(user)

			first_field = "You have been added to the queue. The queue now is :"
			queue = queue_generator(line)

		elsif text == "view"
			line = find_or_create_line(channel_id, channel_name)

			first_field = "The queue now is :"
			queue = queue_generator(line)

		elsif text == "pop"
			if poppers_array.include?(user_id)
				line = find_or_create_line(channel_id, channel_name)

				if line.users.count > 0
					popped_user = line.users.first.user_name
					line.users.first.destroy

					first_field = "You popped the user - #{popped_user}. The queue now is :"
					queue = queue_generator(line)
				else
					first_field = "There's nothing to pop, son!"
					queue = " "
				end
			else
				first_field = "You aren't allowed to pop the queue. If you think you should be, please contact an admin."
				queue = " "
			end

		else
			first_field = "I don't get it. Perhaps you should check the documentation, son. Here's the link : https://github.com/FarazPatankar/qbot"
			queue = " "
		end

		render :json => {
					    "text": first_field,
					    "attachments": [
					        {
					            "text": queue.empty? ? "EMPTY" : queue
					        }
					    ]
					}
	end
end
