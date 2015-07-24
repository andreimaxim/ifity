class Udipity::Server

  class << self
    def start(opts = {})
      host = opts[:host] || '0.0.0.0'
      port = opts[:port] || 9000

      EM.run { 
        EM.open_datagram_socket host, port, Udipity::UDPHandler 
      }
    end
  end
end
