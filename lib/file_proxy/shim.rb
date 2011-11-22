module FileProxy
  module Shim
    def self.included into
      class << into
	def open file_name, *args, &blk
          uri = URI.parse file_name
          puts uri.scheme.inspect
          proxy = Proxy.new uri.scheme
          proxy.open file_name, *args, &blk
        end
      end
    end
  end
end
