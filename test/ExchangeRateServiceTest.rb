require "test/unit"
require_relative "..\\ExchangeRatesCache"
require_relative "..\\ExchangeRateProvider"
require_relative "..\\ExchangeRateService"

class MockExchangeRateProvider
    def initialize
        @rates = ExchangeRatesCache.new
    end
    def loadExchangeRates()
        return @rates
    end
    def setRate(date, currencyCode, rate)
        @rates.set(date, currencyCode, rate)
    end
end

class TestExchangeRateService < Test::Unit::TestCase

    def test_service_should_return_rate_for_date
        utcDateNow = Time.now.utc.to_date
        mockRateProvider = MockExchangeRateProvider.new
        mockRateProvider.setRate(utcDateNow, "USD", 1.166)
        mockRateProvider.setRate(utcDateNow, "GBP", 0.905)
        exchangeRateService = ExchangeRateService.new(mockRateProvider)
        rateUsdToGbp = exchangeRateService.getRateAt(utcDateNow, "USD", "GBP")
        assert(rateUsdToGbp > 0)
    end

    def test_service_should_return_rate_as_float
        utcDateNow = Time.now.utc.to_date
        mockRateProvider = MockExchangeRateProvider.new
        mockRateProvider.setRate(utcDateNow, "USD", 1.166)
        mockRateProvider.setRate(utcDateNow, "GBP", 0.905)
        exchangeRateService = ExchangeRateService.new(mockRateProvider)
        rateUsdToGbp = exchangeRateService.getRateAt(utcDateNow, "USD", "GBP")
        assert(rateUsdToGbp.kind_of? Float)
    end

    def test_service_should_raise_error_for_future_date
        utcDateNow = Time.now.utc.to_date
        mockRateProvider = MockExchangeRateProvider.new
        mockRateProvider.setRate(utcDateNow, "USD", 1.166)
        mockRateProvider.setRate(utcDateNow, "GBP", 0.905)
        exchangeRateService = ExchangeRateService.new(mockRateProvider)
        assert_raise RuntimeError do
            exchangeRateService.getRateAt(utcDateNow + 1, "USD", "GBP")
        end
    end

end