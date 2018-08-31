require 'date'

module ExchangeRateProviderType
    EuropeanCentralBank = 1
    # TODO: add more providers here if required.
end

module ExchangeRateProviderFactory
    def self.make(providerType)
        if(providerType == ExchangeRateProviderType::EuropeanCentralBank)
            return EuropeanCentralBankProvider.new
        end
        # TODO: add more providers here if required.
    end
end

class EuropeanCentralBankProvider
    def loadExchangeRates()
        puts "Loading exchange rate data..."
        rates = ExchangeRatesCache.new
        xmlFileName = "data/forex_data.xml"
        download = open('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml')
        IO.copy_stream(download, xmlFileName)
        @doc = Nokogiri::XML(File.open(xmlFileName))
        nodes = @doc.xpath("//eurofxref:Cube[@time]", "eurofxref" => "http://www.ecb.int/vocabulary/2002-08-01/eurofxref")
        nodes.each { |node|
            attributes = node.attributes
            if(attributes.has_key? "time")
                ratesDate = Date.parse(attributes["time"])
                node.children.each { |rateNode|
                    rates.set(ratesDate, rateNode['currency'], rateNode['rate'].to_f)
                }
            end
        }
        return rates
    end
end