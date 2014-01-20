require 'statsd'

module AdhearsionStats

  class << self
    attr_accessor :statsd, :loaded, :metrics_logger
  end

  class Plugin < Adhearsion::Plugin

    config :statsd do
      host "127.0.0.1",  desc: "The host that statsd is found at"
      port 8125,         desc: "The port that statsd is found at"
      log_metrics false, desc: "Whether or not to log stats sent to statsd"
    end

    init :statsd do
      AdhearsionStats.setup_logger if Adhearsion.config.statsd.log_metrics

      AdhearsionStats.statsd = Statsd.new Adhearsion.config.statsd.host, Adhearsion.config.statsd.port
      AdhearsionStats.loaded = true

      logger.info "Adhearsion-Stats has been loaded"
    end
  end

  class << self
    def method_missing(meth, *args, &blk)
      if Adhearsion.config[:statsd].log_metrics
        metrics_logger.send :info, "#{meth}(#{args.join(",")})"
      end
      AdhearsionStats.statsd.send meth, *args
    end
  end
end
