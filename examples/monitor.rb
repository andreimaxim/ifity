#!/usr/bin/env ruby -w

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'udipity'
require 'curses'

Udipity.configure do |config|
  config.tick = 1
end

class Udipity::Monitor

  include Curses

  class << self
    def start opts = {}
      Curses.init_screen
      Curses.start_color
      Curses.init_pair(Curses::COLOR_GREEN, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
      Curses.init_pair(Curses::COLOR_RED, Curses::COLOR_RED, Curses::COLOR_BLACK)
      Curses.crmode
      Curses.noecho

      monitor = Udipity::Monitor.new

      EM.run { EM.add_periodic_timer(Udipity.configuration.tick) { monitor.check } }

    ensure
      Curses.close_screen
    end
  end

  def initialize
  end

  def storage
    @storage ||= Udipity::Storage.instance
  end

  def check
    clear
    curs_set 0

    client_offset = 1
    write 0, 0, "Current clients:"

    storage.clients.sort_by { |c| c.id }.each_with_index do |client, i|
      write client_offset + i + 1, 0, '%3.3s: %s' % [i + 1, client.id]

      if client.online?
        info client_offset + i + 1, 20, client.status
      else
        warn client_offset + i + 1, 20, client.status
      end
    end

    refresh
  end

  def write x, y, text
    setpos x, y
    addstr text
  end

  def warn x, y, text
    setpos x, y
    attron(color_pair(COLOR_RED)|A_NORMAL) { addstr text }
  end

  def info x, y, text
    setpos x, y
    attron(color_pair(COLOR_GREEN)|A_NORMAL) { addstr text }
  end
end

Udipity::Monitor.start
