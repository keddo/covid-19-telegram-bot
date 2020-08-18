require 'telegram/bot'
require_relative 'config'
require_relative 'api_request'
class Bot
  def self.start_bot
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        id = nil
        begin
           if message.instance_of?(Telegram::Bot::Types::Message)
             id = message.chat.id
             api = ApiRequest.new
             case message.text
             when '/start'
               bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} \n" + api.instroduction)
             when '/help'
               bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} \n" + api.help)
             when '/global'
               res = api.global_status
               bot.api.send_message(chat_id: message.chat.id, text: api.print_global_status(res))
             when %r{^/country}
               text = message.text.split(' ')
               if text[1].nil?
                 bot.api.send_message(chat_id: message.chat.id, text: 'pls, enter your country like, /country ethiopia', date: message.date)
               else 
                 res = api.status_by_country(text[1])
                 bot.api.send_message(chat_id: message.chat.id, text: api.print_country_status(res), date: message.date)
               end
             when %r{^/continent}
               text = message.text.split(' ')
               continent = text.length > 2 ? (text[1] + ' ' + text[2]) : text[1]
               if text.length == 1
                 bot.api.send_message(chat_id: message.chat.id, text: 'pls, enter your continent like, /continent africa', date: message.date)
               else
                 res = api.status_by_continent(continent)
                 bot.api.send_message(chat_id: message.chat.id, text: api.print_continent_status(res), date: message.date)
               end 
             when %r{^/highest}
               text = message.text.split(' ')
               str = api.top_cases(text[1].to_i)
               bot.api.send_message(chat_id: message.chat.id, text: str, date: message.date)
             when %r{^/history}
               text = message.text.split(' ')
               if text[1].nil? || text[2].nil?
                 bot.api.send_message(chat_id: message.chat.id, text: 'make sure you give the right command', date: message.date)
               else
                 str = api.historical(text[2], text[1])
                 bot.api.send_message(chat_id: message.chat.id, text: str, date: message.date)
               end
             when '/stop'
               bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
             else 
               bot.api.send_message(chat_id: message.chat.id, text: 'pls, enter the right command')
             end
           end
        rescue StandardError => e
          puts e.message
          unless id.nil?
            bot.api.send_message(chat_id: id, text: 'Sorry about that, can you enter again, and
                check for spelling errors this time :-)')
          end
          next
         end
      end
    end
  end
end
