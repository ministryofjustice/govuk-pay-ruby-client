# GOV.UK Pay ruby client (basic functionality)

This is a basic little gem to serve as an API client for [GOV.UK Pay](https://www.payments.service.gov.uk).

Currently it supports:

* Create a credit card payment
* Get payment details by ID

It might support more operations in the future.

It is not intended to be a full featured API client and in fact is made simple on purpose. There are other clients out there with more functionality.

## Installation

Prior to usage a GOV.UK Pay account must be created. This will provide the API credentials needed in you application.

You can then install the gem or require it in your application.

```ruby
gem 'govuk-pay-ruby-client'
```

## Usage

### Configuration

You need to configure the client before you can use it. You can do this, for example with an initializer:

```ruby
require 'payments_api'

PaymentsApi.configure do |config|
  config.api_key = ENV['GOVUK_PAY_API_KEY']
end
````

There are several options you can configure, like open and read timeouts, logging, and more. Please refer to the [Configuration class](lib/payments_api/configuration.rb) for more details.

### Creating a payment

Refer to the [API documentation](https://govukpay-api-browser.cloudapps.digital/#create-a-payment) to know the properties you can post.

```ruby
response = PaymentsApi::Requests::CreateCardPayment.new(
  amount: 215_00,
  description: 'Payment description',
  reference: 'Payment reference',
  return_url: 'https://myservice.justice.uk',
  
  # Any other optional properties, for example:
  email: 'user@test.com',
  metadata: {
    foo: 'bar',
  }
).call
```

This will return a `Responses::PaymentResult` class with the API response mapped to instance attributes, and some helper methods. For example:

```ruby
response.payment_id  # "1234567890"
response.state       # {"status"=>"created", "finished"=>false}
response.status      # "created"
response.finished?   # false
response.payment_url # URL where to redirect your user to complete the payment
```

### Retrieving a payment

Refer to the [API documentation](https://govukpay-api-browser.cloudapps.digital/#get-a-payment) for more details.

```ruby
response = PaymentsApi::Requests::GetCardPayment.new(
  payment_id: '1234567890'
).call
```

This, as with the create action, will return a `Responses::PaymentResult` class with the API response mapped to instance attributes, and some helper methods. For example:

```ruby
response.payment_id # "1234567890"
response.state      # {"status"=>"success", "finished"=>true}
response.status     # "success"
response.finished?  # true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This gem uses rubocop and simplecov (at 100% coverage).

## Contributing

Bug reports and pull requests are welcome.

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit until you are happy with your contribution (`git commit -am 'Add some feature'`)
4. Push the branch (`git push origin my-new-feature`)
5. Make sure your changes are covered by tests, so that we don't break it unintentionally in the future.
6. Create a new pull request.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
