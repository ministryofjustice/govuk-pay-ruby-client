# Payments ruby client (basic and limited functionality)

This is a very basic, and very much work in progress gem to serve as an API client for [GOV.UK Pay](https://www.payments.service.gov.uk).

Currently it supports:

* Create a credit card payment

When finished it will at least handle the basic operations to create card payments, query the status of a transaction by ID, as well as the events, and probably search and cancel functionality as well.

It is not intended to be a full featured API client and in fact is made simple on purpose. There are other clients out there with more functionality.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'govuk-pay-ruby-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install govuk-pay-ruby-client

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ministryofjustice/govuk-pay-ruby-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
