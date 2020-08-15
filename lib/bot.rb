require 'telegram/bot'
require_relative 'config'
require_relative 'api_request'
class Bot 

    def self.startBot
        Telegram::Bot::Client.run(TOKEN) do |bot|
            bot.listen do |message|
              case message.text
              when '/start'
                bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} \n" + ApiRequest.instroduction)
              when '/help'
                bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} \n" + ApiRequest.help)
              when '/global'
                res = ApiRequest.getGlobalStatus
                bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.printGlobalStatus(res))
              when %r{^/country}
                text = message.text.split(' ')
                res = ApiRequest.getstatusByCountry(text[1])
                bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.printCountryStatus(res), date: message.date)
              when %r{^/continent}
                text = message.text.split(' ')
                continent = text.length > 2 ? (text[1] + ' ' + text[2]) : text[1]
                res = ApiRequest.getstatusByContinent(continent)
                bot.api.send_message(chat_id: message.chat.id, text: ApiRequest.printContinentStatus(res), date: message.date)
              when '/stop'
                bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
              end
            end
        end
    end
end