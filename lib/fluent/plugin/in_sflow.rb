require 'cool.io'
require 'fluent/plugin/parser_sflow'


module Fluent
  class SflowInput < Input
    Plugin.register_input('sflow', self)

    config_param :bind, :string, default: '0.0.0.0'
    config_param :port, :integer, default: 6343
    config_param :tag, :string
    config_param :max_bytes, :integer, default: 2048


    def configure(conf)
      super
      @parser = Fluent::TextParser::SflowParser.new
    end

    def start
      super
      @loop = Coolio::Loop.new
      @handler = listen(method(:receive))
      @loop.attach @handler

      @thread = Thread.new(&method(:run))
    end

    def shutdown
      @loop.watchers.each {|w| w.detach }
      @loop.stop
      @handler.close
      @thread.join
      super
    end

    def run
      @loop.run
    rescue
      log.error 'unexpected error', error_class: $!.class, error: $!.message
      log.error_backtrace
    end


    protected

    def receive(raw, exporter)
      log.on_debug do
        log.debug 'received sflow datagram', raw: raw, exporter: exporter
      end

      @parser.parse(raw, exporter) do |time, record|
        if !time || !record
          log.warn 'Failed to parse', raw: raw, exporter: exporter
          return
        end

        router.emit(@tag, time, record)
      end
    rescue
      log.warn 'Unexpected error on parsing',
               raw: raw, exporter: exporter, error_class: $!.class, error: $!.message
    end


    private

    def listen(callback)
      log.info "listening sflow socket on #{@bind}:#{@port}"
      @sock = SocketUtil.create_udp_socket(@bind)
      @sock.bind @bind, @port
      UdpHandler.new @sock, callback
    end

    class UdpHandler < Coolio::IO
      def initialize(io, callback)
        super io
        @io = io
        @callback = callback
      end

      def on_readable
        msg, addr = @io.recvfrom_nonblock(4096)
        @callback.call msg, addr[3]
      end
    end
  end
end
