require 'optparse'
require 'singleton'
require 'securerandom'
require 'curses'
require 'eventmachine'
require 'logger'
require 'redis'
require 'rainbow'
require 'rainbow/ext/string'

require 'udipity/version'
require 'udipity/cli'

# Main services
require 'udipity/server'
require 'udipity/client'
require 'udipity/monitor'
require 'udipity/loader'

# Commands
require 'udipity/command_builder'
require 'udipity/command'
require 'udipity/command/hello'
require 'udipity/command/ping'
require 'udipity/command/exit'

# Plumbing et al
require 'udipity/datagram'
require 'udipity/udp_handler'
require 'udipity/storage'

module Udipity
  TICK = 1
  LONG_TICK = 5

  def self.logger
    @logger ||= begin
                  l = Logger.new(STDOUT)
                  l.level = Logger::INFO
                  l.formatter = proc { |_, date, _, msg| "#{date}: #{msg}\n" }

                  l
                end

  end
end
