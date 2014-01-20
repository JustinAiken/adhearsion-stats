require 'adhearsion'
require 'adhearsion-stats'
require 'support/statsd_test_helper'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.color_enabled = true
  config.tty = true

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

