# ifity

This is a simple gem that provides three tools:

* a server that allows UPD connections on a specific port
* a client that connects to the above server and sends state
* a real-time monitor for the server clients

The clients authenticate, get a task they need to work on, report back with 
their progress and disconnect. The monitor is supposed to show all that
information in real time.

## Installation

You need to install the gem using the following command:

    $ gem install ifity

The server and the monitor require a Redis server to be running on localhost
on port 6379. 

## Usage

For the server:

    $ ifity

or

    $ ifity --server

For the monitor:

    $ ifity --monitor

For a client:

    $ ifity --client -h 192.168.0.100 -p 9000 -n aName

The client takes three options:

* `-h` the host or IP address of the server
* `-p` the port of the server
* `--auth` the authentication string

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ifity/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
