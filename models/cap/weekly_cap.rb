require_relative 'base_cap'
require './models/timing/day'

module Cap
  class WeeklyCap < Cap::BaseCap
    attr_reader :longest_journey, :weekly_running_cost

    def initialize
      @current_week_day = Timing::Day.new(day: -1)
      @weekly_total_cost = 0
      @longest_journey = Journey.new(from: 0, to: 0)
    end

    def calculate_capped_cost(cost:, fare_cap:)
      remaining_cap = fare_cap.weekly_fare_cap - @weekly_total_cost
      puts("Weekly Total cost: #{@weekly_total_cost}")
      puts("Weekly remaining cap: #{remaining_cap}")
      [remaining_cap, cost].min
    end

    def update_day(next_day:)
      @current_week_day = next_day
    end

    def add_to_total_cost(cost:)
      @weekly_total_cost += cost
    end

    private
      def reset_total_cost
        @weekly_total_cost = 0
      end

      def reset_cap?(next_day:)
        new_week_started?(next_day: next_day)
      end

      def new_week_started?(next_day:)
        @current_week_day > next_day
      end

  end
end
