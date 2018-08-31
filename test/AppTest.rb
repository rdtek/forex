require "cuba/test"
require "./App"

scope do
  test "GetHomepage" do
    get "/"
    assert_equal last_response.status, 200
  end
  test "PostExchangeRate" do
    utcDateNow = Time.now.utc.to_date
    get "/exchangerate", { date: utcDateNow.strftime("%F"), currency1: "USD", currency2: "GBP" }
    assert_equal last_response.status, 200
    assert Float(last_response.body) != nil
  end
end
