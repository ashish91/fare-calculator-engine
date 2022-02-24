require 'date'
module Timing
  class TimingRange
    def initialize(timing_range:)
      @start_time = to_datetime(time: timing_range[0])
      @end_time = to_datetime(time: timing_range[1])
    end

    def within_range?(time:)
      dt = to_datetime(time: time)
      (@start_time..@end_time).cover?(dt)
    end

    private
    def to_datetime(time:)
      hour, mins = time.split(':').map(&:to_i)
      DateTime.new(2018, 6, 28, hour, mins, 00)
    end
  end
end
