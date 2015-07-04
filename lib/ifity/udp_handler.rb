class Ifity::UDPHandler < EventMachine::Connection

  def receive_data data
    Ifity::Datagram.new(data).run callback
  end

  private
  def callback
    EM::DefaultDeferrable.new.callback { |r| send_data(r + "\n") }
  end
end
