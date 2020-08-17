require_relative '../lib/bot'
require_relative '../lib/api_request'
puts 'Welcome to covid-19 information bot'
# Bot.start_bot
p ApiRequest.json_response('https://disease.sh/v3/covid-19/all')
