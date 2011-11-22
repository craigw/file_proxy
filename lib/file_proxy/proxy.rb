module FileProxy
  class Proxy
    def initialize scheme
      self.class.instance_eval do
        include proxy_for scheme
      end
    end

    def self.proxy_for scheme
      return Proxies::FileProxy if scheme.nil?
      proxy = scheme.dup
      proxy[0] = proxy[0].upcase
      Proxies.const_get "#{proxy}Proxy"
    end
  end
end
