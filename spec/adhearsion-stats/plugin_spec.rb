require 'spec_helper'

describe AdhearsionStats do

  let(:logfile) { double "File", 'sync=' => true }
  before { File.stub(:open).and_return logfile }

  describe "plugin configuration" do
    it "sets the default values" do
      Adhearsion.config[:statsd].host.should == '127.0.0.1'
      Adhearsion.config[:statsd].port.should == 8125
      Adhearsion.config[:statsd].log_metrics.should be_false
    end
  end

  describe "initialization" do

    before do
      subject
      Adhearsion.config[:statsd].log_metrics = true
      Adhearsion::Plugin.initializers.each { |plugin_initializer| plugin_initializer.run }
    end

    it "sets init variables" do
      subject.statsd.should be_an_instance_of Statsd
      subject.statsd.host.should == "127.0.0.1"
      subject.statsd.port.should == 8125

      subject.metrics_logger.should be_an_instance_of AdhearsionStats::MetricsLogger
      subject.loaded.should be_true
    end

    describe "the plugin" do
      let(:statsd)     { FakeStatsd.new }
      let(:stats_sent) { statsd.socket.buffer.flatten }

      before { subject.statsd = statsd }

      it "has methods that calls statsd" do
        subject.increment "foo"
        subject.timing "bar", 100
        subject.gauge "biz", "+1"

        stats_sent.should include "foo:1|c"
        stats_sent.should include "bar:100|ms"
        stats_sent.should include "biz:+1|g"
      end

      describe "logging" do
        it "adds logging to all reporting methods" do
          subject.metrics_logger.should_receive(:info).with 'increment(foo)'
          subject.increment "foo"

          subject.metrics_logger.should_receive(:info).with 'timing(bar,100)'
          subject.timing "bar", 100
        end
      end
    end
  end
end
