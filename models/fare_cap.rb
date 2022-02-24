class FareCap
  attr_reader :journey, :daily_fare_cap, :weekly_fare_cap

  def initialize(from:, to:, daily_fare_cap:, weekly_fare_cap:)
    @journey = Journey.new(from: from, to: to)
    @weekly_fare_cap = weekly_fare_cap
    @daily_fare_cap = daily_fare_cap
  end

end
