class Udipity::Server

  class << self

    def start opts = {}
      host = opts[:host]
      port = opts[:port]

      EM.run { 
        storage.clean_slate

        EM.open_datagram_socket host, port, Udipity::UDPHandler 
      }
    end
  end
end
