# lita-webhookr


**lita-webhookr** is a handler for [Lita](https://github.com/jimmycuadra/lita) that listens for HTTP messages and posts them in the channel.

## Installation

Add lita-webhookr to your Lita instance's Gemfile:

``` ruby
gem "lita-webhookr"
```

## Configuration

### Required attributes

* `api_key` (String) .

### Example

``` ruby
Lita.configure do |config|
  config.handlers.webhookr.api_key = ENV['webhookr_api_key']
end
```

## Usage

Just do a GET with the api_key param and a message param at: `http://address.of.lita/webhookr`
```
curl -X GET "http://address.of.lita/webhookr?api_key=abc123&message=Hey"

## License

[MIT](http://opensource.org/licenses/MIT)
