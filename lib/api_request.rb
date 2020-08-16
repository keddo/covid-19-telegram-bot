require 'net/http'
require 'json'
require_relative 'config'
class ApiRequest
  attr_accessor :request_token;

  def self.getGlobalStatus
    escaped_address = URI.escape(GLOBAL_URL)
    uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end

  def self.getstatusByCountry(country)
      url = COUNTRIES_URL + "/" + country
     escaped_address = URI.escape(url)
     uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end

  def self.getstatusByContinent(continent)
      url = CONTINENT_URL
     escaped_address = URI.escape(url)
     uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response = response.select { |hash| continent.split.map(&:capitalize).join(' ') == hash['continent'] }
    response[0]
  end
  
  def self.getCountriesWithTopCases(number)
     url = COUNTRIES_URL + "?sort=cases"
     response = jsonResponse(url)
     countries = {}
     number.times do |i|
        countries[response[i]['country']] = response[i]['cases']
     end
     str = ""
     countries.each do |k, v|
      str += printTopCases(k, v) + "\n"
     end
     str
  end


  def self.printGlobalStatus(res)
    <<~HEREDOC 
    ----------------------------------------------
    |              Worldwide                     
    ----------------------------------------------
    | Total Cases: #{res['cases'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}         
    ----------------------------------------------
    | Today Cases: #{res['todayCases'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}            
    ----------------------------------------------
    | Critical: #{res['critical'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}                
    ----------------------------------------------
    | Total Deaths: #{res['deaths'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}              
    ----------------------------------------------
    | Total Recovered: #{res['recovered'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}    
    ----------------------------------------------
    | Active: #{res['active'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}                    
    ----------------------------------------------    
    HEREDOC
  end

  def self.printCountryStatus(res)
      <<~HEREDOC 
      ----------------------------------------------
      |#{res['country']}                            
      ----------------------------------------------
      | New Confirmed: #{res['todayCases'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}         
      ----------------------------------------------
      | Total Confirmed: #{res['cases'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}            
      ----------------------------------------------
      | Critical: #{res['critical'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}                
      ----------------------------------------------
      | Total Deaths: #{res['deaths'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}              
      ----------------------------------------------
      | Total Recovered: #{res['recovered'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}        
      ----------------------------------------------
      | Total Affected: #{res['affectedCountries'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse} 
      ----------------------------------------------
      | Active: #{res['active'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}                    
      ----------------------------------------------    
      HEREDOC
  end


  def self.printContinentStatus(res)
    <<~HEREDOC 
    ----------------------------------------------
    |#{res['continent']}                            
    ----------------------------------------------
    | New Confirmed: #{res['todayCases'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}         
    ----------------------------------------------
    | Total Confirmed: #{res['cases'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}            
    ----------------------------------------------
    | Critical: #{res['critical'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}                
    ----------------------------------------------
    | Today Deaths: #{res['todayDeaths'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}              
    ----------------------------------------------
    | Total Deaths: #{res['deaths'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}              
    ----------------------------------------------
    | Today Recovered: #{res['todayRecovered'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse} 
    ----------------------------------------------
    | Total Recovered: #{res['recovered'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse} 
    ----------------------------------------------
    | Active: #{res['active'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}                    
    ----------------------------------------------    
    HEREDOC
  end
  def self.instroduction
      <<~HEREDOC
      Welcome to COVID-19 bot, this bot is using the disease service API 
      to generate information about COVID-19 based on the options 
      you enter so please enter from the given chooses and 
      the bot will reply:
      /start - give main information about the bot
      /help - use to get help 
      /global - returns global cases
      /country countryname|code - return COVID status of the country
      /continent content name - return COVID status of the continent
      /highest  number - countries with highest number of cases upto the number
      -------------------------------
     | Powered by Kedir A.      
      -------------------------------
      HEREDOC
  end
  def self.printTopCases(country, cases)
    '----------------------' +
    "|#{country} : #{cases.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}"
    +
    '---------------------'
  end
  def self.help
      <<~HEREDOC
      Welcome to Covid-19_bot help center
      1. In case of searching for a country  you must use space
      bewtween /country & the country name or code
      2. Make sure country name is spelt correctly.
      3. We will add more help ASAP.
      -------------------------------
     | Powered by Kedir A.      
      -------------------------------
      HEREDOC
  end

  def self.jsonResponse(url)
    escaped_address = URI.escape(url)
    uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end
end