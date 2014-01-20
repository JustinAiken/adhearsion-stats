# Adhearsion Stats [![Build Status](https://secure.travis-ci.org/JustinAiken/adhearsion-stats.png?branch=master)](http://travis-ci.org/JustinAiken/adhearsion-stats)[![Code Climate](https://codeclimate.com/github/JustinAiken/adhearsion-stats.png)](https://codeclimate.com/github/JustinAiken/adhearsion-stats)[![Coverage Status](https://coveralls.io/repos/JustinAiken/adhearsion-stats/badge.png)](https://coveralls.io/r/JustinAiken/adhearsion-stats)

This is an Adhearsion plugin for sending metrics to a [statsd server](https://github.com/etsy/statsd/).

It uses the [statsd gem](https://github.com/reinh/statsd).

## Usage Example

```ruby
class WellTrackedCallController < Adhearsion::CallController

  before_call :start_stats
  after_call  :end_stats

  def run
    answer
    ...
    hangup
  end

private

  def start_stats
    @call_started = Time.now.to_f
    AdhearsionStats.increment "calls.started"
    AdhearsionStats.gauge "calls.in_progress", "+1"
  end

  def end_stats
    AdhearsionStats.gauge "calls.in_progress", "-1"

    #Track call duration in ms
    call_duration = Time.now.to_f - @call_started
    AdhearsionStats.timing "calls.length", (call_duration * 1000).to_i
  end
end
```

### Links

* [Adhearsion](http://adhearsion.com)
* [Source](https://github.com/JustinAiken/adhearsion-stats)
* [Bug Tracker](https://github.com/JustinAiken/adhearsion-stats/issues)

### Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  * If you want to have your own version, that is fine but bump version in a commit by itself so I can ignore when I pull
* Send me a pull request. Bonus points for topic branches.

### Credits

Original author: [JustinAiken](https://github.com/JustinAiken)

Developed for [Mojo Lingo](http://mojolingo.com).

### Copyright

Copyright (c) 2013 Adhearsion Foundation Inc. MIT license (see LICENSE for details).
