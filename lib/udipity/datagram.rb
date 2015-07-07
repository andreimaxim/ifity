class Udipity::Datagram

  attr_reader :cmd

  def initialize data
    @cmd = Udipity::CommandBuilder.from_datagram data
    @cmd.run
  end

  # Run any kind fo 
  def run defer
    EM.defer {
      if cmd.needs_ack?
        Udipity.logger.debug cmd.ack
        defer.succeed cmd.ack
      end
    }
  end
end
