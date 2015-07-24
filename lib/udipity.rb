require 'optparse'
require 'singleton'
require 'securerandom'
require 'eventmachine'
require 'logger'
require 'time'
require 'redis'

require 'udipity/version'
#require 'udipity/cli'
require 'udipity/configuration'
# Main services
require 'udipity/server'
require 'udipity/client'

# Commands
require 'udipity/command_builder'
require 'udipity/command'
require 'udipity/command/hello'
require 'udipity/command/ping'

# Plumbing et al
require 'udipity/datagram'
require 'udipity/udp_handler'
require 'udipity/storage'

module Udipity

  def self.logger
    @logger ||= begin
                  l = Logger.new(Udipity.configuration.log_output)
                  l.level = Udipity.configuration.log_level
                  l.formatter = Udipity.configuration.log_format

                  l
                end

  end

  def self.configuration
    @configuration ||= Udipity::Configuration.new
  end

  def self.configure
    yield configuration
  end
end
