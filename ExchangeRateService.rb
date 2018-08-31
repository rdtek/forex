require "open-uri"
require "nokogiri"
require "date"
require_relative "ExchangeRatesCache"
require_relative "ExchangeRateProvider"

class ExchangeRateService

  def initialize(exchangeRateProvider)
    @rateProvider = exchangeRateProvider
    @rates = @rateProvider.loadExchangeRates()
  end

  def getAvailableCurrencies
    # todo: return list of supported currencies from rates cache.
  end

  def getRateAt(date, currency1, currency2)

    if date > (Time.now.utc.to_date + 1)
      raise RuntimeError, "Error: can not fetch exchange rate for future date."
    end

    if @rates.empty || @rates.isOld
      @rates = @rateProvider.loadExchangeRates()
    end

    # Get exchange rates relative to base currency
    currency1Rate = @rates.get(date, currency1)
    currency2Rate = @rates.get(date, currency2)

    # Calculate rate from currency1 to currency2
    currency1RateCurrency2 = currency2Rate / currency1Rate

    return currency1RateCurrency2
  end

end