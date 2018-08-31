require 'date'

class ExchangeRatesCache
  def initialize()
    # Instance variables
    @hashRates = Hash.new
    @utcDateUpdated = Time.now.utc.to_date
  end

  def formatDate(date)
    date.strftime("%F")
  end

  def isOld
    now = Time.now.utc.to_date
    diff = (@utcDateUpdated - now).to_i
    return (diff >= 1)
  end

  def set(date, currencyCode, rate)
    dateString = formatDate(date)
    if(not @hashRates.has_key? dateString)
      @hashRates[dateString] = Hash.new
    end
    @hashRates[dateString][currencyCode] = rate
    @utcDateUpdated = Time.now.utc.to_date
  end

  def get(date, currencyCode)
    dateString = formatDate(date)
    if(not @hashRates.has_key? dateString)
      raise "Error: no exchange rates found for date #{dateString}"
    end
    return @hashRates[dateString][currencyCode]
  end

  def empty
    return @hashRates.empty?
  end
end