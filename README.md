# GrapeDbLogger

Database logger for Grape.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'grape_db_logger'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape_db_logger

## Usage

Execute the following commands to generate the required migration:

    $ rails generate grape_db_logger
    $ rake db:migrate

Then tell Grape to use the log middleware and start logging follow the next step or read the [grape documentation](https://github.com/ruby-grape/grape#grape-middleware) for detailed instructions:
```ruby
class API < Grape::API
  # Add this line
  use GrapeDbLogger::Logger

  # Your code...
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MirkoMignini/grape_db_logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
