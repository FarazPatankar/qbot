module SlackApiHelper
	def response_generator(line)
		response = ""

		line.users.each_with_index do |el, i|
			response += "#{i + 1}. #{el.user_name}\n"
		end

		response
	end
end
