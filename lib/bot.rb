require 'telegram/bot'
require_relative 'config'
require_relative 'api_request'
class Bot
  def self.start_bot
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} \n" + ApiRequest.instroduction)
        when '/help'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} \n" + ApiRequest.help)
        when '/global'
          res = ApiRequest.global_status
          bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.print_global_status(res))
        when %r{^/country}
          text = message.text.split(' ')
          res = ApiRequest.status_by_country(text[1])
          bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.print_country_status(res), date: message.date)
        when %r{^/continent}
          text = message.text.split(' ')
          continent = text.length > 2 ? (text[1] + ' ' + text[2]) : text[1]
          res = ApiRequest.status_by_continent(continent)
          bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.print_continent_status(res), date: message.date)
        when %r{^/highest}
          text = message.text.split(' ')
          str = ApiRequest.top_cases(text[1].to_i)
          bot.api.send_message(chat_id: message.chat.id, text: str, date: message.date)
        when %r{^/history}
          text = message.text.split(' ')
          str = ApiRequest.historical(text[2], text[1])
          bot.api.send_message(chat_id: message.chat.id, text: str, date: message.date)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        end
      end
    end
  end
end
