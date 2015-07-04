class Ifity::Command::Exit < Ifity::Command

  CMD = 'exit'
  
  protected

  def cmd
    CMD
  end

  def run_hooks
    @needs_ack = true
    Ifity::logger.info "Client #{client.id} is properly disconnecting"
    storage.remove client
  end
end
