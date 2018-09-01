# forex
Web app to fetch exchange rates and convert currency.

Built using the [Cuba](https://github.com/soveran/cuba) framework which is based on [Rack](https://rack.github.io/). 

## Screenshot
![screen shot of web app](https://raw.githubusercontent.com/rdtek/forex/master/Screenshot.png)

## Install
Use the `gem install` command to install the following dependencies:

```
gem install cuba
gem install tilt
gem install rack-test
gem install rackup
gem install rerun # optional - to watch file changes and rerun app automatically during development.
```

## Run
Run the following command at the root of the app directory.
This will start a server on localhost port 9292.
Open the URL in a web browser http://localhost:9292/.
```
rackup
```
Or
```
rerun rackup # watches for file changes and re-runs app 
```

## Test
```
ruby test\AppTest.rb
ruby test\ExchangeRateServiceTest.rb
```

