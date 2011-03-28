require "rubygems"
require "httparty"

class Messente  
  
  include HTTParty
  
  base_uri "https://messente.com/api"
  
  def initialize(options)
    @defaults = options
  end

  def send(options)
    query = @defaults.merge(options)
    
    response = self.class.get("/send_sms_get", :query => query)
    items    = response.split(" ")  
    return false if ("ERROR" == items[0])
     
    {:id => items[1], :price => items[2].to_f}
  end
  
  def balance
    response = self.class.get("/get_balance/#{@defaults[:user]}/#{@defaults[:api_key]}")
    items    = response.split(" ")
    return false if ("ERROR" == items[0])

    items[1].to_f
  end
  
  def report(options) 
    response = self.class.get("/get_dlr_response/#{@defaults[:user]}/#{@defaults[:api_key]}/#{options[:id]}")
    pp items    = response.split(" ")
    return false if ("ERROR" == items[0])
    
    items[1] 
  end 
  
end