class Udipity::CommandBuilder

  class << self
    def from_datagram datagram = ''
      parts = datagram.split

      id = parts.shift
      cmd = parts.shift

      create_command cmd, id, data: parts.join(' ')
    end

    def create_command cmd, id,  opts = {}
      klass_name = "Udipity::Command::#{cmd.capitalize}"

      klass = if Object.const_defined? klass_name
                Object.const_get klass_name
              else
                Udipity::Command
              end

      klass.new Udipity::Client.new(id), opts
    end
  end
end
