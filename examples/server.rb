#!/usr/bin/env ruby -w

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'udipity'

Udipity.configure do |config|
  config.tick = 10
end

begin
  Udipity::Server.start host: '0.0.0.0', port: 9000
rescue SystemExit, Interrupt
  Udipity.logger.info 'Shutting down...'
end
