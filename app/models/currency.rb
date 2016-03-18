require 'net/http'
require 'json'
class Currency < ActiveRecord::Base
    def self.get_currency_iso(currency_id)
        iso = ''
        currency = Currency.where("id = ?", currency_id)
        if currency.present?
            iso = currency.first.iso
        end
        iso
    end
    
    def self.convert_currency(amount,from_curr,to_curr)
        host = "www.google.com"
        http = Net::HTTP.new(host, 80)

        url = "/finance/converter?a=#{amount}&from=#{from_curr}&to=#{to_curr}"
        response = http.get(url)
        result = response.body
        regexp = Regexp.new("(\\d+\\.{0,1}\\d*)\\s+#{to_curr}")
        regexp.match result
        return $1.to_f
    end
    
    def currency_name; "#{name} (#{iso})";end
end
