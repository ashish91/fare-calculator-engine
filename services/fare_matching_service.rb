require 'yaml'
require './models/fare.rb'
require './services/timing_matching_service'

class FareMatchingService
  CONFIG_DIR = './config/'.freeze

  def initialize
    @timing_matching_service = TimingMatchingService.new
    load_fares_configs
  end

  def find_cost(day:, time:, from:, to:)
    fare = get_fare_by_matching_zones(from: from, to: to)

    matched_timing_type = get_matching_timing_type(day: day, time: time)
    puts "Matched timing type: #{matched_timing_type}"

    fare.get_cost_by_timing_type(timing_type: matched_timing_type)
  end

  def get_matching_timing_type(day:, time:)
    @timing_matching_service.get_matching_timing_type_identifier(day: day, time: time)
  end

  def get_fare_by_matching_zones(from:, to:)
    @fares.detect { |fare| fare.matches_zone?(from: from, to: to) }
  end

  private
  def load_fares_configs
    fares_config = YAML.load_file("#{CONFIG_DIR}/fares.yml")
    @fares = fares_config['fares'].map do |fare|
      Fare.new(
        from: fare['zones']['from'],
        to: fare['zones']['to'],
        cost_by_timing_type: fare['cost_by_timing_type']
      )
    end
  end
end
