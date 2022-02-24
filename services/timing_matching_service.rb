require 'yaml'
require './models/timing/timing_type.rb'

class TimingMatchingService
  CONFIG_DIR = './config/'.freeze

  def initialize
    load_timing_configs
  end

  def get_matching_timing_type_identifier(day:, time:)
    timing_type = @timings.detect do |timing_type|
      timing_type.matches_a_day_time_range?(day: day, time: time)
    end
    timing_type&.identifier || @default_timing_type
  end

  private
  def load_timing_configs
    timings = YAML.load_file("#{CONFIG_DIR}/timings.yml")
    @timings = timings['timings'].map do |identifier, timing|
      Timing::TimingType.new(identifier: identifier, day_time_ranges: timing)
    end
    @default_timing_type = timings['default']
  end
end
