require 'net/http'
class DashboardsController < ApplicationController
    before_action :set_params_values

    def index
       @converted_value = Currency.convert_currency(@original_amt,@from_curr,@to_curr)
    end
    
    def convert_currency
        begin
            if @original_amt.present? && @original_amt.to_i > 0
                @converted_value = Currency.convert_currency(@original_amt,@from_curr,@to_curr)
            else
                flash[:error] = 'Please enter amount for conversion.'
                render
            end
        rescue Exception => ex
        end        
    end

    :private

    def set_params_values
        @currencies = Currency.all
        @from_curr = params[:currency1].present? ? Currency.get_currency_iso(params[:currency1]) : "USD"
        @to_curr = params[:currency2].present? ? Currency.get_currency_iso(params[:currency2]) : "INR"
        @original_amt = params[:currency_value].present? ? params[:currency_value][:currency_value] : 1
        @converted_value = 0.0
    end
end
