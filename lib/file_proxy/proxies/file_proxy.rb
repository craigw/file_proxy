module FileProxy
  module Proxies
    module FileProxy
      def remote
        @remote ||= SimpleDelegator.new(OriginalFile)
      end

      def method_missing *args, &blk
        remote.send *args, &blk
      end
    end
  end
end
