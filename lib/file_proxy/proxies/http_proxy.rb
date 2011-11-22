module FileProxy
  module Proxies
    module HttpProxy
      def open url, *args, &blk
        uri = URI.parse url
        data = Net::HTTP.get uri
        buffer = '/tmp/' + Time.now.to_s + rand(1_000_000_000_000).to_s
        ::FileProxy::OriginalFile.open buffer, 'w+' do |f|
          f.print data
        end
        ::FileProxy::OriginalFile.open buffer, *args, &blk
      end
    end
  end
end
