# Await-Rb
[![Maintainability](https://api.codeclimate.com/v1/badges/bf4aa74f7f3c2661540f/maintainability)](https://codeclimate.com/github/xtrasimplicity/await_rb/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/bf4aa74f7f3c2661540f/test_coverage)](https://codeclimate.com/github/xtrasimplicity/await_rb/test_coverage)

A simple Ruby gem to help ensure external dependencies are operational, when booting an application (or anything at all!).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'await_rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install await_rb

## Usage
Simply execute the Await-Rb rake task for the protocol you'd like to check, and then start your dependencies on successful completion. For example, if you want to make sure a MySQL server (e.g. `172.20.0.10`) is running before you run your Ruby/Rack/Sinatra application, you can run:

```ruby
bundle exec rake await:tcp host=172.20.0.10 port=3306 && ruby -e "puts 'MySQL is listening.'"
```

By default, Await-Rb will time out after `10 minutes` (`600 seconds`) if a connection cannot be established. To change this, simply pass a new value (in `seconds`), to the `timeout` environment variable. e.g.

```ruby
bundle exec rake await:tcp host=172.20.0.10 port=3306 timeout=300 && ruby -e "puts 'Hello world!'"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/await_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AwaitRb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/await_rb/blob/master/CODE_OF_CONDUCT.md).
