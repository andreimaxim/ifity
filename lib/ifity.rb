require 'optparse'
require 'singleton'
require 'securerandom'
require 'curses'
require 'eventmachine'
require 'logger'
require 'redis'
require 'rainbow'
require 'rainbow/ext/string'

require 'ifity/version'
require 'ifity/cli'

# Main services
require 'ifity/server'
require 'ifity/client'
require 'ifity/monitor'
require 'ifity/loader'

# Commands
require 'ifity/command_builder'
require 'ifity/command'
require 'ifity/command/hello'
require 'ifity/command/ping'
require 'ifity/command/exit'

# Plumbing et al
require 'ifity/datagram'
require 'ifity/udp_handler'
require 'ifity/storage'

module Ifity
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
