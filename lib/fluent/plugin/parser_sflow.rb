require 'fluent/plugin/parser'
require 'fluent/time'
require 'json'
require 'sflowtool'


module Fluent
  module Plugin
    class SflowParser < Parser
      Plugin.register_parser('sflow', self)

      config_param :estimate_current_event, :bool, default: false


      def parse(raw, remote_host)
        data = JSON.load(Sflowtool.parse(raw, remote_host))
        time = if @estimate_current_event
                 Fluent::EventTime.now
               else
                 Fluent::EventTime.new(data['header']['unix_seconds_utc'])
               end

        data['samples'].each do |sample|
          yield time, data['header'].merge(sample)
        end
      end
    end
  end
end
