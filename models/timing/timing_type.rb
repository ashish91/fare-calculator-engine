require_relative 'day_time_ranges'

module Timing
  class TimingType
    attr_reader :identifier

    def initialize(identifier:, day_time_ranges:)
      @identifier = identifier
      @day_time_ranges = day_time_ranges.map do |day_time|
        Timing::DayTimeRanges.new(
          days: day_time['days'],
          timing_ranges: day_time['timings'],
        )
      end
    end

    def matches_a_day_time_range?(day:, time:)
      @day_time_ranges.detect { |ranges| ranges.lies_within_any_range?(day: day, time: time) }
    end

  end
end
