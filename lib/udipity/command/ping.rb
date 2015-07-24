class Udipity::Command::Ping < Udipity::Command
  
  CMD = 'ping'

  protected

  def run_hooks
    @needs_ack = client_available?
    storage.ping client
  end

  def client_available?
    storage.check client
  end
end
