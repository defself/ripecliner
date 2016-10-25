module RIPECLINER

  class CLI

    def initialize(params)
      @command  = params[0]
      @argument = params[1]

      invoke_command
    end

    def invoke_command
      case @command
      when "download"
        dump = RIPECLINER::BGPDump.new
        dump.date = @argument
        dump.download
      when "convert"
        dump = RIPECLINER::BGPDump.new

        if @argument
          dump.file = @argument
        else
          raise ArgumentError.new("Please, specify dump file for converting / downloading.")
        end

        dump.convert
      when "-h", "--help"
        CLI.print_help
      when "-v", "--version"
        puts RIPECLINER::VERSION
      else
        raise ArgumentError.new("Unrecognized command")
      end
    end

    def self.print_help
      puts <<~HELP
        ripecliner is a CLI Downloader & Transformer for RIPE Routing Information Service

          Usage:
            bin/ripecliner -h/--help
            bin/ripecliner -v/--version
            bin/ripecliner command [argument]

          Examples:
            bin/ripecliner download <date>
            bin/ripecliner convert <file>

          Further information:
            https://github.com/defself/ripecliner
      HELP
    end
  end

end
