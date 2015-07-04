class Ifity::Datagram

  attr_reader :cmd

  def initialize data
    @cmd = Ifity::CommandBuilder.from_datagram data
    @cmd.run
  end

  # Run any kind fo 
  def run defer
    EM.defer {
      if cmd.needs_ack?
        Ifity::logger.debug cmd.ack
        defer.succeed cmd.ack
      end
    }
  end
end
