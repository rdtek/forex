require "cuba"
require "cuba/safe"
require "cuba/render"
require "erb"
require "./ExchangeRateService"
require "./ExchangeRateProvider"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"
Cuba.use Rack::Static, urls: ["/public"]

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render

rateProvider = ExchangeRateProviderFactory.make(ExchangeRateProviderType::EuropeanCentralBank)
exchangeRateService = ExchangeRateService.new(rateProvider)

Cuba.define do
  on get do
    on root do
      render("index")
    end
    on "exchangerate" do
        on param("date"), param("currency1"), param("currency2") do |dateString, currency1, currency2|
          date = Date.parse(dateString)
          # TODO: handle error when no exchange rate found e.g. when provider has
          # not published new exchange rate data for current day.
          rate = exchangeRateService.getRateAt(date, currency1, currency2)
          res.write "#{rate}"
        end
        on true do
          res.write "You need to provide the paramters: date, currency1 and currency2."
        end
    end
  end
end
