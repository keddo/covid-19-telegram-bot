require 'net/http'
require 'json'
require_relative 'config'
class ApiRequest
  def initialize; end

  def global_status
    response = json_response(GLOBAL_URL)
    response
  end

  def status_by_country(cry)
    return "Country don't exist" if country_exist(cry).empty?

    url = COUNTRIES_URL + '/' + cry
    response = json_response(url)
    response
  end

  def status_by_continent(con)
    url = CONTINENT_URL
    response = json_response(url)
    response = response.select { |hash| con.split.map(&:capitalize).join(' ') == hash['continent'] }
    response[0]
  end

  def top_cases(num)
    url = COUNTRIES_URL + '?sort=cases'
    response = json_response(url)
    countries = {}
    num.times do |i|
      countries[response[i]['country']] = response[i]['cases']
    end
    str = ''
    i = 1
    countries.each do |k, v|
      str += print_top_cases(k, v, i) + "\n"
      i += 1
    end
    str
  end

  def historical(day, cry)
    url = HISTORICAL_URL + '?lastdays=' + day
    response = json_response(url)
    result = response.select { |data| data['country'] == cry.split.map(&:capitalize).join(' ') }
    str = "#{result[0]['country']}\n"
    result[0]['timeline']['cases'].each { |k, v| str += print_history(k, v) }
    str
  end

  def print_global_status(res)
    <<~HEREDOC
      ----------------------------------------------
      |              Worldwide                     
      ----------------------------------------------
      | Total Cases: #{res['cases'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}         
      ----------------------------------------------
      | Today Cases: #{res['todayCases'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}            
      ----------------------------------------------
      | Critical: #{res['critical'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}                
      ----------------------------------------------
      | Total Deaths: #{res['deaths'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}              
      ----------------------------------------------
      | Total Recovered: #{res['recovered'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}    
      ----------------------------------------------
      | Active: #{res['active'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}                    
      ----------------------------------------------    
    HEREDOC
  end

  def print_country_status(res)
    <<~HEREDOC
      ----------------------------------------------
      |#{res['country']}                            
      ----------------------------------------------
      | New Confirmed: #{res['todayCases'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}         
      ----------------------------------------------
      | Total Confirmed: #{res['cases'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}            
      ----------------------------------------------
      | Critical: #{res['critical'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}                
      ----------------------------------------------
      | Total Deaths: #{res['deaths'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}              
      ----------------------------------------------
      | Total Recovered: #{res['recovered'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}        
      ----------------------------------------------
      | Total Affected: #{res['affectedCountries'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse} 
      ----------------------------------------------
      | Active: #{res['active'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}                    
      ----------------------------------------------    
    HEREDOC
  end

  def print_continent_status(res)
    <<~HEREDOC
      ----------------------------------------------
      |#{res['continent']}                            
      ----------------------------------------------
      | New Confirmed: #{res['todayCases'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}         
      ----------------------------------------------
      | Total Confirmed: #{res['cases'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}            
      ----------------------------------------------
      | Critical: #{res['critical'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}                
      ----------------------------------------------
      | Today Deaths: #{res['todayDeaths'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}              
      ----------------------------------------------
      | Total Deaths: #{res['deaths'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}              
      ----------------------------------------------
      | Today Recovered: #{res['todayRecovered'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse} 
      ----------------------------------------------
      | Total Recovered: #{res['recovered'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse} 
      ----------------------------------------------
      | Active: #{res['active'].to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}                    
      ----------------------------------------------    
    HEREDOC
  end

  def print_history(key, val)
    "\n-----------------------\n| #{key} | #{val.to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}"
  end

  def instroduction
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
       /highest  number - countries with highest number of cases upto 
        the number
       /history  CountryName numberofdays - show the history of 
       COVID-19 cases of the country for the given number 
       of days . 
       -------------------------------
      | Powered by Kedir A.      
       -------------------------------
    HEREDOC
  end

  def print_top_cases(cry, cas, num)
    "-----------------------\n| #{num} | #{cry} : #{cas.to_s.reverse.gsub(/...(?=.)/, '\&,').reverse}"
  end

  def help
    <<~HEREDOC
       Welcome to Covid-19_bot help center
       1. In case of searching for a country  you must use space
       bewtween /country & the country name or code -> eg. /country Ethiopia
       2. Make sure country name is spelt correctly.
       3. After /highest use a number -> eg. /highest 5.
       4. To get the histor of  your country or any send request to the bot
       as eg. /history Ethiopia 5 
       -------------------------------
      | Powered by Kedir A.      
       -------------------------------
    HEREDOC
  end

  private

  def country_exist(ctry)
    country = ''
    countries = included_countries
    countries.each { |c| country = c if c == ctry.split.map(&:capitalize).join(' ') } 
    country
  end

  def included_countries
    data = json_response('https://disease.sh/v3/covid-19/countries')
    countries = []
    data.each { |country| countries << country['country'] }
    countries
  end

  def json_response(url)
    escaped_address = URI.escape(url)
    uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end
end
