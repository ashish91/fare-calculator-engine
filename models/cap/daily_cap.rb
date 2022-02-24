require_relative 'base_cap'
require './models/timing/day'

module Cap
  class DailyCap < Cap::BaseCap
    attr_reader :longest_journey, :daily_total_cost

    def initialize
      @current_day = Timing::Day.new(day: -1)
      @daily_total_cost = 0
      @longest_journey = Journey.new(from: 0, to: 0)
    end

    def calculate_capped_cost(cost:, fare_cap:)
      remaining_cap = fare_cap.daily_fare_cap - @daily_total_cost
      puts("Daily Total cost: #{@daily_total_cost}")
      puts("Daily remaining cap: #{remaining_cap}")
      [remaining_cap, cost].min
    end

    def update_day(next_day:)
      @current_day = next_day
    end

    def add_to_total_cost(cost:)
      @daily_total_cost += cost
    end

    private
      def reset_total_cost
        @daily_total_cost = 0
      end

      def reset_cap?(next_day:)
        new_day_started?(next_day: next_day)
      end

      def new_day_started?(next_day:)
        !(@current_day == next_day)
      end

  end
end
