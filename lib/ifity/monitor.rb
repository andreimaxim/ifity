class Ifity::Monitor

  include Curses

  class << self
    def start opts = {}
      Curses.init_screen
      Curses.crmode

      monitor = Ifity::Monitor.new

      EM.run { EM.add_periodic_timer(Ifity::TICK) { monitor.check } }

    ensure
      Curses.close_screen
    end
  end

  def initialize

  end

  def storage
    @storage ||= Ifity::Storage.instance
  end

  def check
    clear
    curs_set 0

    client_offset = 1
    write 0, 0, 'Current clients:'

    storage.list.each_with_index do |client, i|
      write client_offset + i + 1, 0, "#{i + 1}: #{client.id}"
    end
  end

  def write x, y, text
    setpos x, y; addstr text; refresh
  end
end
