module Cap
  class BaseCap

    def update_farthest_journey(day:, from:, to:)
      if reset_cap?(next_day: day)
        @longest_journey.update(from: from, to: to)
        reset_total_cost
      else
        @longest_journey.update_farthest_journey(from: from, to: to)
      end
      update_day(next_day: day)
    end

    def reset_cap
      @longest_journey.reset_zones
      reset_total_cost
    end

  end
end
