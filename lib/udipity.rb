require 'optparse'
require 'singleton'
require 'securerandom'
require 'eventmachine'
require 'logger'
require 'redis'

require 'udipity/version'
require 'udipity/cli'

# Main services
require 'udipity/server'
require 'udipity/client'

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

  DEFAULT_LOG_LEVEL = Logger::INFO
  DEFAULT_LOG_OUTPUT = STDOUT
  DEFAULT_LOG_FORMAT = proc { |_, date, msg| "#{date}: #{msg}\n" }

  def self.logger
    @logger ||= begin
                  level  = Udipity.config :log_level
                  output = Udipity.config :log_output
                  format = Udipity.config :log_format

                  l = Logger.new(output)
                  l.level = Logger::INFO

                  l = Logger.new(STDOUT)
                  l.level = Logger::INFO
                  l.formatter = proc { |_, date, _, msg| "#{date}: #{msg}\n" }

                  l
                end

  end
end
