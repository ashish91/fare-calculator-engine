require File.join(Dir.pwd, 'specs/spec_helper')

describe "FareMatchingService" do
  before :each do
    @fare_matching_service = FareMatchingService.new
  end

  it 'matches peak hours' do
    cost = @fare_matching_service.find_cost(
      day: 'Monday', time: '10:20', from: 2, to: 1
    )
    expect(cost).to eq(35)
  end

  it 'matches non peak hours' do
    cost = @fare_matching_service.find_cost(
      day: 'Monday', time: '10:45', from: 1, to: 1
    )
    expect(cost).to eq(25)
  end

  it 'matches peak hours when time 10:30 and peak hours are 7:00 to 10:30' do
    cost = @fare_matching_service.find_cost(
      day: 'Monday', time: '10:30', from: 2, to: 1
    )
    expect(cost).to eq(35)
  end

  it 'matches peak and non peak hours on zones 2-2' do
    cost = @fare_matching_service.find_cost(
      day: 'Sunday', time: '09:30', from: 2, to: 2
    )
    expect(cost).to eq(25)
    cost = @fare_matching_service.find_cost(
      day: 'Saturday', time: '11:30', from: 2, to: 2
    )
    expect(cost).to eq(20)
  end
end
