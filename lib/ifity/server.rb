class Ifity::Server

  TIMEOUT = 5

  class << self

    def start(opts = {})
      host = opts[:host]
      port = opts[:port]

      EM.run { 
        storage.clean_slate

        EM.open_datagram_socket host, port, Ifity::UDPHandler 
        EM.add_periodic_timer(TIMEOUT) { remove_old_clients }
      }
    end

    def storage
      Ifity::Storage.instance
    end

    def remove_old_clients
      clients = storage.list

      Ifity::logger.info "Veryfing #{clients.size} clients...".color(:yellow)

      clients.each do |c|
        time_diff = (Time.now - c.timestamp).to_i

        if time_diff > TIMEOUT
          Ifity::logger.info "Removing #{c.id}, client expired #{c.timestamp}".color(:green)
          storage.remove c
        else
          Ifity::logger.debug "Found #{c.id}, still has #{TIMEOUT - time_diff} seconds to live"
        end
      end
    end
  end
end
