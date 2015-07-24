#!/usr/bin/env ruby -w

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'udipity'
require 'rainbow/ext/string'

# Clean up all the 
Udipity::Storage.instance.clean_slate

MAX_DURATION = 50
PING_INTERVAL = 0.2

CLIENT_IDS = %w[
  1fa097
  2e9675
  553e8f
  58cc2a
  629f58
  865389
  89fe93
  8a085a
  c8ecc9
  cc5677
  ceb90d
  ecf3fa
  f4a513
  f8c9b0
  fe7574
]

def start_clients
  threads = []

  CLIENT_IDS.each do |client_id|
    threads << Thread.new do
      # Adding some randomness in order to simulate actual network usage
      duration = SecureRandom.random_number MAX_DURATION
      client = Udipity::Client.new client_id

      Udipity.logger.info "Client " + "#{client.id}".color(:green) + " started"
      client.connect

      (duration / PING_INTERVAL).to_i.times do
        sleep PING_INTERVAL

        client.ping
      end

      Udipity.logger.info "Client " + "#{client.id}".color(:red) + " finished"
    end
  end

  threads.map(&:join)
end

loop do 
  Udipity.logger.info 'Starting clients...'
  start_clients

  sleep 10
end
