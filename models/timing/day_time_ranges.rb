require_relative 'day'
require_relative 'timing_range'

module Timing
  class DayTimeRanges

    def initialize(days:, timing_ranges:)
      @days = build_days(days: days)
      @timing_ranges = build_timing_ranges(timing_ranges: timing_ranges)
    end

    def lies_within_any_range?(day:, time:)
      same_day?(day: day) && within_time_range?(time: time)
    end

    def same_day?(day:)
      @days.any? { |d| d.equals?(day: day) }
    end

    def within_time_range?(time:)
      @timing_ranges.any? { |timing| timing.within_range?(time: time) }
    end

    private
    def build_days(days:)
      days.map { |day| Timing::Day.new(day: day) }
    end

    def build_timing_ranges(timing_ranges:)
      timing_ranges.map { |timing_range| Timing::TimingRange.new(timing_range: timing_range) }
    end

  end
end
