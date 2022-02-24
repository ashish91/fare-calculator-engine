class Journey
  attr_reader :from, :to
  def initialize(from:, to:)
    @from = from
    @to = to
  end

  def matches?(from:, to:)
    @from == from && @to == to
  end

  def ==(obj)
    @from == obj.from && @to == obj.to
  end

  def update(from:, to:)
    @from = from
    @to = to
  end

  def update_farthest_journey(from:, to:)
    new_journey = Journey.new(from: from, to: to)
    if self.journey_not_set? or new_journey.greater_than?(self)
      @from = from
      @to = to
    end
  end

  def greater_than?(obj)
    (@to - @from).abs > (obj.to - obj.from).abs
  end

  def journey_not_set?
    @from == 0 and @to == 0
  end

end
