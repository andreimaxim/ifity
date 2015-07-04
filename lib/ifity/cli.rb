class Ifity::CLI

  DEFAULT_HOST = '0.0.0.0'
  DEFAULT_PORT = 9000
  DEFAULT_REDIS_HOST = 'localhost'
  DEFAULT_REDIS_PORT = 6379
  
  class << self
    MODES = %w[ server client monitor loader ]

    def parse(argv)
      options = {}
      defaults = { 
        mode: Ifity::Server,

        host: DEFAULT_HOST,
        port: DEFAULT_PORT
      }

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: ifity <type>'

        opts.separator ''
        opts.separator 'Run options:'

        mode_list = MODES.join(', ')
        opts.on('--mode MODE', MODES, "Specify mode: #{mode_list}") do |m|
          klass = "Ifity::#{m.to_s.capitalize}"
          options[:mode] = Object.const_get(klass)
        end

        opts.on('-l', '--length INT', 'Duration of the client (seconds)') do |l|
          opts[:duration] = l.to_i
        end

        opts.on('-h', '--host IP', 'Server host') do |h|
          options[:host] = h.to_i
        end

        opts.on('-p', '--port INT', 'Server port') do |p|
          options[:port] = p.to_i
        end

        opts.separator ''
        opts.separator 'More information:'

        opts.on_tail('--help', 'Show this message') do
          puts opts
          exit
        end

        opts.on_tail('--version', 'Show the current version') do
          puts Ifity::VERSION
          exit
        end
      end

      opt_parser.parse! argv
      defaults.merge(options)
    rescue OptionParser::InvalidOption => io
      puts "Invalid option: #{io.recover argv}"

      puts "\n"

      opt_parser.parse! ['-h']
    end
  end
end
