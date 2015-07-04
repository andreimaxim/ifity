class Udipity::Client

  attr_reader :id
  attr_accessor :timestamp
  
  attr_reader :host
  attr_reader :port

  class Handler < EM::Connection
  end

  class << self
    def start opts = {}
      duration = opts.delete(:duration) || 60
      ping_interval = 0.2

      client = Udipity::Client.new nil, opts

      Udipity::logger.info "Client #{client.id} started"

      client.connect

      (duration / ping_interval).to_i.times do
        sleep ping_interval

        client.ping
      end

      client.disconnect
    end
  end

  def initialize id = nil, opts = {}
    @id = id || SecureRandom.hex(3)
    @timestamp = opts[:timestamp] || Time.now
    @buggy = opts[:buggy]

    @host = opts.fetch(:host) { '0.0.0.0' }
    @port = opts.fetch(:port) { 9000 }
  end

  def buggy?
    !!@buggy
  end

  def connect
    run Udipity::Command::Hello.new(self).syn
  end

  def disconnect
    if buggy?
      Udipity::logger.info "Client #{id} is buggy!".color(:red)
    else
      Udipity::logger.info "Client #{id} disconnected"
      run Udipity::Command::Exit.new(self).syn
    end
  end

  def ping
    run Udipity::Command::Ping.new(self).syn
  end

  def run cmd
    Udipity::logger.debug cmd
    socket.send cmd, 0, host, port
    cmd
  end

  def socket
    @socket ||= UDPSocket.new
  end
end
