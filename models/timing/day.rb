module Timing
  class Day

    attr_reader :day_number
    DAYS = {
      'Monday' => 0,
      'Tuesday' => 1,
      'Wednesday' => 2,
      'Thursday' => 3,
      'Friday' => 4,
      'Saturday' => 5,
      'Sunday' => 6
    }.freeze

    def initialize(day:)
      @day_number = DAYS[day].nil? ? day : DAYS[day]
    end

    def equals?(day:)
      @day_number == DAYS[day]
    end

    def ==(obj)
      @day_number == obj.day_number
    end

    def >(obj)
      @day_number > obj.day_number
    end

  end
end
