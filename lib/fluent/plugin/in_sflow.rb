require 'fluent/plugin/input'
require 'fluent/plugin/parser_sflow'


module Fluent::Plugin
  class SflowInput < Input
    Fluent::Plugin.register_input('sflow', self)

    helpers :server

    config_param :bind, :string, default: '0.0.0.0'
    config_param :port, :integer, default: 6343
    config_param :tag, :string
    config_param :max_bytes, :integer, default: 2048

    def multi_workers_ready?
      true
    end

    def configure(conf)
      super
      @parser = Fluent::Plugin::SflowParser.new
    end

    def start
      super
      shared_socket = system_config.workers > 1
      server_create(:in_sflow_server, @port, proto: :udp, bind: @bind, shared: shared_socket, max_bytes: @max_bytes) do |data, sock|
        receive(data, sock.remote_host)
      end
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
  end
end
