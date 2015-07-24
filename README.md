[![Build Status](https://travis-ci.org/andreimaxim/udipity.svg?branch=master)](https://travis-ci.org/andreimaxim/udipity)
[![Code Climate](https://codeclimate.com/github/andreimaxim/udipity/badges/gpa.svg)](https://codeclimate.com/github/andreimaxim/udipity)
[![Test Coverage](https://codeclimate.com/github/andreimaxim/udipity/badges/coverage.svg)](https://codeclimate.com/github/andreimaxim/udipity/coverage)
[![Dependency Status](https://gemnasium.com/andreimaxim/udipity.svg)](https://gemnasium.com/andreimaxim/udipity)
[![Inline docs](http://inch-ci.org/github/andreimaxim/udipity.svg?branch=master)](http://inch-ci.org/github/andreimaxim/udipity)

# udipity

This is a library that provides two tools:

* a server that accepts a specific set UDP commands
* a client for sending UDP commands


## Installation

You need to install the gem using the following command:

    $ gem install udipity

The server and the monitor require a Redis server to be running on localhost
on port 6379. 

## Usage


```ruby
require 'udipity'

host = '0.0.0.0' # UDP connections require an IP address
port = 9000

class Udipity::Command::Foo < Udipity::Command
  # Add code
end

Udipity::Server.register Udipity::Command::Foo
Udipity::Server.start host, port
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/udipity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
