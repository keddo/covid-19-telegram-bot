require_relative '../lib/bot'
require_relative '../lib/api_request'
puts 'Welcome to covid-19 information bot'

# api = ApiRequest.new
# p api.is_country_exist('ethiopia')
Bot.start_bot
