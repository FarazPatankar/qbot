module SlackApiHelper
	def response_generator(line)
		response = ""

		line.users.each_with_index do |el, i|
			response += "#{i + 1}. #{el.user_name}\n"
		end

		response
	end

	def find_or_create_line(channel_id, channel_name)
		Line.find_or_create_by(channel_id: channel_id) do |line|
			line.channel_name = channel_name
		end
	end

	def find_or_create_user(user_id, user_name)
		User.find_or_create_by(user_id: user_id) do |user|
			user.user_name = user_name
		end
	end
end
