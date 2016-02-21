# Rebay2

This gem is based on Rebay is a very simple wrapper for the ebay finding and shopping APIs.  Additonal calls were add to Finding class.  Merchandising API was also added along with configuiring calls to the Ebay API to include affiliate information that can be added to the configuration file.

Add this line to your application's Gemfile:

```ruby
gem 'rebay2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rebay2

## Usage

Configuration
-------------
Create and require a config.rb, or if using rails create an initializer (rebay2.rb perhaps), and place the following code into it:

  Rebay2::Api.configure do |rebay2|
    rebay2.app_id = 'YOUR APPLICATION ID HERE'
    rebay2.tracking_id = 'YOUR CAMPAIN ID HERE'
    rebay2.network_id = 'tracking partner for affiliate commissions'  # will default 9 if not specified
  end

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rebay2. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

