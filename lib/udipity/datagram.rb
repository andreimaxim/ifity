class Udipity::Datagram

  attr_reader :cmd

  def initialize data
    @cmd = Udipity::CommandBuilder.from_datagram data
    @cmd.run
  end

  # Run any kind fo 
  def run defer
    EM.defer {
      ack = cmd.ack
      Udipity.logger.debug ack
      defer.succeed ack
    }
  end
end
