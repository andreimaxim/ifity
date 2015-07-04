class Udipity::Command::Exit < Udipity::Command

  CMD = 'exit'
  
  protected

  def cmd
    CMD
  end

  def run_hooks
    @needs_ack = true
    Udipity::logger.info "Client #{client.id} is properly disconnecting"
    storage.remove client
  end
end
