require 'yaml'
require './models/fare_cap.rb'
require './models/cap/daily_cap.rb'
require './models/cap/weekly_cap.rb'
require './models/timing/day.rb'

class FareCappingService
  CONFIG_DIR = './config/'.freeze

  def initialize
    @caps = [ Cap::DailyCap.new, Cap::WeeklyCap.new ]
    load_configs
  end

  def capped_cost(day:, from:, to:, cost:)
    day = Timing::Day.new(day: day)
    puts("Day: #{day.day_number}")
    puts("Calculated Cost: #{cost}")
    puts
    @caps.each do |cap|
      cap.update_farthest_journey(day: day, from: from, to: to)

      fare_cap = get_matching_fare_cap(longest_journey: cap.longest_journey)
      if fare_cap
        cost = cap.calculate_capped_cost(cost: cost, fare_cap: fare_cap)
      end
      cap.add_to_total_cost(cost: cost)
    end
    puts("Final Capped Cost: #{cost}")
    puts '*' * 50
    cost
  end

  private
  def get_matching_fare_cap(longest_journey:)
    @fare_caps.detect { |cap| cap.journey == longest_journey }
  end

  def load_configs
    fare_caps_config = YAML.load_file("#{CONFIG_DIR}/fare_caps.yml")
    @fare_caps = fare_caps_config['cappings'].map do |fare|
      FareCap.new(
        from: fare['zones']['from'],
        to: fare['zones']['to'],
        weekly_fare_cap: fare['weekly'],
        daily_fare_cap: fare['daily']
      )
    end
  end
end
