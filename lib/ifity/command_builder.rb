class Ifity::CommandBuilder

  class << self
    def from_datagram datagram = ''
      parts = datagram.split

      id = parts.shift
      cmd = parts.shift

      create_command cmd, id, data: parts.join(' ')
    end

    def create_command cmd, id,  opts = {}
      klass_name = "Ifity::Command::#{cmd.capitalize}"

      klass = if Object.const_defined? klass_name
                Object.const_get klass_name
              else
                Ifity::Command
              end

      klass.new Ifity::Client.new(id), opts
    end
  end
end
