require 'net/http'
require 'json'

class ApiRequest
  attr_accessor :request_token;
  
  def getGlobalStatus
    escaped_address = URI.escape(@url)
    uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end

  def getstatusByCountry(country)
     url = @url + "?#{token_var}=" + token
     escaped_address = URI.escape(url)
     uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end

  def getRequestedNumber(request_var, request_number)
    
  end
end