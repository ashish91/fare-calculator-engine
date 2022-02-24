require './models/journey'
class Fare

  def initialize(from:, to:, cost_by_timing_type:)
    @journey = Journey.new(from: from, to: to)
    @cost_by_timing_type = cost_by_timing_type
  end

  def matches_zone?(from:, to:)
    @journey.matches?(from: from, to: to)
  end

  def get_cost_by_timing_type(timing_type:)
    @cost_by_timing_type[timing_type]
  end

end
