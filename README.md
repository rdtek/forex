# forex
Web app to fetch exchange rates and convert currency.

Built using the [Cuba](https://github.com/soveran/cuba) framework which is based on [Rack](https://rack.github.io/). 

## Install
```
gem install cuba
gem install tilt
gem install rack-test
gem install rackup
gem install rerun # for hot reload
```

## Run
```
rackup
```
Or
```
rerun rackup
```

## Test
```
ruby test\AppTest.rb
ruby test\ExchangeRateServiceTest.rb
```

## Screenshot
![screen shot of web app](https://raw.githubusercontent.com/rdtek/forex/master/Screenshot.png)
