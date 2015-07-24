class Udipity::Client

  attr_reader :id
  attr_accessor :timestamp
  
  attr_reader :host
  attr_reader :port

  def initialize id = nil, opts = {}
    @id = id || SecureRandom.hex(3)
    @timestamp = opts[:timestamp] || Time.now
    @buggy = opts[:buggy]

    @host = opts.fetch(:host) { '0.0.0.0' }
    @port = opts.fetch(:port) { 9000 }
  end

  def status
    time = Time.now
    offset = Udipity.configuration.tick

    if time - timestamp > offset
      'offline'
    else
      'online'
    end
  end

  def online?
    status == 'online'
  end

  def offline?
    status == 'offline'
  end

  def connect
    run Udipity::Command::Hello.new(self).syn
  end

  def ping
    run Udipity::Command::Ping.new(self).syn
  end

  def run cmd
    Udipity.logger.debug cmd
    socket.send cmd, 0, host, port
    cmd
  end

  def socket
    @socket ||= UDPSocket.new
  end
end
