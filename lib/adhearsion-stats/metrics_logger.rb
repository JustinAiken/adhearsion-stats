require 'logger'

module AdhearsionStats

  class MetricsLogger < Logger
    def format_message(severity, timestamp, progname, msg)
      nice = timestamp.strftime("%Y-%m-%d %I:%M:%S %p")
      "#{nice}: #{msg}\n"
    end
  end

  def self.setup_logger
    logfile         = File.open("#{Adhearsion.root}/log/adhearsion-stats.log", 'a')
    logfile.sync    = true
    @metrics_logger = MetricsLogger.new(logfile)
  end
end
