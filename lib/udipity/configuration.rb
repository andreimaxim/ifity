class Udipity::Configuration

  DEFAULT_LOG_LEVEL = Logger::INFO
  DEFAULT_LOG_OUTPUT = STDOUT
  DEFAULT_LOG_FORMAT = proc { |_, date, _, msg| "#{date}: #{msg}\n" }

  DEFAULT_REDIS_URL = 'redis://localhost:6379'

  DEFAULT_TICK = 5

  # Logger setting
  attr_accessor :log_level
  attr_accessor :log_output
  attr_accessor :log_format

  # Redis host
  attr_accessor :redis_url

  attr_accessor :tick

  def initialize
    @log_level = DEFAULT_LOG_LEVEL
    @log_output = DEFAULT_LOG_OUTPUT
    @log_format = DEFAULT_LOG_FORMAT

    @redis_url = DEFAULT_REDIS_URL

    @tick = DEFAULT_TICK
  end
end
