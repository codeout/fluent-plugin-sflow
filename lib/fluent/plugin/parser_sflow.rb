require 'fluent/plugin/parser'
require 'fluent/time'
require 'json'
require 'sflowtool'


module Fluent
  module Plugin
    class SflowParser < Parser
      Plugin.register_parser('sflow', self)


      def parse(raw, remote_host)
        data = JSON.load(Sflowtool.parse(raw, remote_host))

        # NOTE: sFlow datagram doesn't have timestamp field, but sysUpTime only
        time = Fluent::EventTime.new(data['header']['unix_seconds_utc'])

        data['samples'].each do |sample|
          yield time, data['header'].merge(sample)
        end
      end
    end
  end
end
