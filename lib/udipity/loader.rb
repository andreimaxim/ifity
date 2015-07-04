class Udipity::Loader
  class << self
    def start opts = {}
      loader = Udipity::Loader.new opts
      loader.start
    end
  end

  attr_reader :max_threads
  attr_reader :max_duration

  def initialize opts = {}
    @max_threads = opts.delete(:max_threads) || 25 
    @max_duration = opts.delete(:max_duration) || 180

    @opts = opts
  end

  def start
    threads = []
    no_of_threads = SecureRandom.random_number max_threads

    no_of_threads.times do
      threads << Thread.new do
        duration = SecureRandom.random_number max_duration
        offset = SecureRandom.random_number max_duration/2
        buggy_client = SecureRandom.random_number max_duration

        sleep offset

        Udipity::Client.start @opts.merge({ duration: duration, buggy: buggy_client % 4 == 0})
      end
    end

    threads.map(&:join)
  end
end
