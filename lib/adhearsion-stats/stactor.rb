module AdhearsionStats
  class Stactor
    include Celluloid

    attr_accessor :statsd

    def initialize(statsd)
      @statsd = statsd
    end

    def send_stat(meth, *args, &blk)
      statsd.send meth, *args, &blk
    end

    def method_missing(meth, *args, &blk)
      self.async.send_stat meth, *args, &blk
    end
  end
end
