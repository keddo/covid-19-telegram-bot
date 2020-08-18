require 'telegram/bot'
require_relative 'config'
require_relative 'api_request'
class Bot
  def self.start_bot
    Telegram::Bot::Client.run(TOKEN) do |bot|
    begin
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
          if text[1].nil?
            bot.api.send_message(chat_id: message.chat.id, text: "pls, enter your country like, /country ethiopia", date: message.date)
          else 
            res = ApiRequest.status_by_country(text[1])
            bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.print_country_status(res), date: message.date)
          end
        when %r{^/continent}
          text = message.text.split(' ')
          continent = text.length > 2 ? (text[1] + ' ' + text[2]) : text[1]
          if text.length == 1
            bot.api.send_message(chat_id: message.chat.id, text: "pls, enter your continent like, /continent africa", date: message.date)
          else
            res = ApiRequest.status_by_continent(continent)
            bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.print_continent_status(res), date: message.date)
          end 
        when %r{^/highest}
          text = message.text.split(' ')
          str = ApiRequest.top_cases(text[1].to_i)
          bot.api.send_message(chat_id: message.chat.id, text: str, date: message.date)
        when %r{^/history}
          text = message.text.split(' ')
          if text[1].nil? || text[2].nil?
            bot.api.send_message(chat_id: message.chat.id, text: "make sure you give the right command", date: message.date)
          else
            str = ApiRequest.historical(text[2], text[1])
            bot.api.send_message(chat_id: message.chat.id, text: str, date: message.date)
          end
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
        else 
          bot.api.send_message(chat_id: message.chat.id, text: "pls, enter the right command")
        end
      end
    end

  rescue Telegram::Bot::Exceptions::ResponseError => e
    # console.log(e)
    p e
    if e.error_code.to_s == '502'
      puts 'telegram stuff, nothing to worry!'
    elsif e.error_code.to_s == '400'
      puts "#{e.error_code }"
    end
    retry
  end
  end
end
