require 'sflowtool/sflowtool'

module Sflowtool
  class << self
    def parse(data, exporter)
      purge_trailing_commas(receive_sflow_datagram(data, exporter))
    end

    private

    def purge_trailing_commas(str)
      str.gsub! ',]', ']'
      str.gsub! ',}', '}'
      str
    end
  end
end
