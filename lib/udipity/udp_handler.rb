class Udipity::UDPHandler < EventMachine::Connection

  def receive_data data
    Udipity::Datagram.new(data).run callback
  end

  private
  def callback
    EM::DefaultDeferrable.new.callback { |r| 
      data = r || 'No data'
      send_data(data + "\n")
    }
  end
end
