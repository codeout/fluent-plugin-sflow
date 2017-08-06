require 'fluent/parser'
require 'json'
require 'sflowtool'


module Fluent
  class TextParser
    class SflowParser < Parser
      Plugin.register_parser('sflow', self)


      def parse(raw, remote_host)
        data = JSON.load(Sflowtool.parse(raw, remote_host))

        # NOTE: sFlow datagram doesn't have timestamp field, but sysUpTime only
        time = data['header']['unix_seconds_utc']

        data['samples'].each do |sample|
          yield time, data['header'].merge(sample)
        end
      end
    end
  end
end
