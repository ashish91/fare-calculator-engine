require File.join(Dir.pwd, 'specs/spec_helper')

describe "FareCappingService" do
  before :each do
    @fare_matching_service = FareMatchingService.new
    @fare_capping_service = FareCappingService.new
  end

  it "caps cost if daily cap reached" do
    [
      ['Monday', '10:20', 2, 1],
      ['Monday', '10:45', 1, 1],
      ['Monday', '16:15', 1, 1],
      ['Monday', '18:15', 1, 1]
    ].each do |inp|
      cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
      capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)

      expect(capped_cost).to eq(cost)
    end

    inp = ['Monday', '19:00', 1, 2]
    cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
    capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    expect(capped_cost).not_to eq(cost)
    expect(capped_cost).to eq(5)
    expect(cost).to eq(35)
  end

  it "resets capped cost if new day started" do
    [
      ['Monday', '10:20', 2, 1],
      ['Monday', '10:45', 1, 1],
      ['Monday', '16:15', 1, 1],
      ['Monday', '18:15', 1, 1],
    ].each do |inp|
      cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
      capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)

      expect(capped_cost).to eq(cost)
    end

    inp = ['Monday', '19:00', 1, 2]
    cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
    capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    expect(capped_cost).not_to eq(cost)

    inp = ['Tuesday', '19:00', 1, 2]
    cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
    capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    expect(capped_cost).to eq(cost)
  end

  it "caps cost if weekly cap reached" do
    [
      ['Monday', '10:20', 1, 2],
      ['Monday', '10:45', 1, 1],
      ['Monday', '16:15', 1, 1],
      ['Monday', '18:15', 1, 1],
      ['Tuesday', '19:00', 1, 2],
      ['Tuesday', '10:20', 1, 2],
      ['Tuesday', '10:45', 1, 1],
      ['Tuesday', '16:15', 1, 1],
      ['Tuesday', '18:15', 1, 1],
      ['Wednesday', '19:00', 1, 2],
      ['Wednesday', '10:20', 1, 2],
      ['Wednesday', '10:45', 1, 1],
      ['Wednesday', '16:15', 1, 1],
      ['Wednesday', '18:15', 1, 1],
      ['Thursday', '19:00', 1, 2],
      ['Thursday', '10:20', 1, 2],
      ['Thursday', '10:45', 1, 1],
      ['Thursday', '16:15', 1, 1],
      ['Thursday', '18:15', 1, 1],
      ['Friday', '19:00', 1, 2],
      ['Friday', '10:45', 1, 1],
      ['Friday', '16:15', 1, 1],
      ['Friday', '18:15', 1, 1],
      ['Saturday', '10:20', 1, 1]
    ].each do |inp|
      cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
      capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    end

    inp = ['Saturday', '10:45', 1, 1]
    cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
    capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    expect(capped_cost).not_to eq(cost)
    expect(capped_cost).to eq(0)
    expect(cost).to eq(25)
  end

  it "resets weekly cap if new week started" do
    [
      ['Monday', '10:20', 1, 2],
      ['Monday', '10:45', 1, 1],
      ['Monday', '16:15', 1, 1],
      ['Monday', '18:15', 1, 1],
      ['Tuesday', '19:00', 1, 2],
      ['Tuesday', '10:20', 1, 2],
      ['Tuesday', '10:45', 1, 1],
      ['Tuesday', '16:15', 1, 1],
      ['Tuesday', '18:15', 1, 1],
      ['Wednesday', '19:00', 1, 2],
      ['Wednesday', '10:20', 1, 2],
      ['Wednesday', '10:45', 1, 1],
      ['Wednesday', '16:15', 1, 1],
      ['Wednesday', '18:15', 1, 1],
      ['Thursday', '19:00', 1, 2],
      ['Thursday', '10:20', 1, 2],
      ['Thursday', '10:45', 1, 1],
      ['Thursday', '16:15', 1, 1],
      ['Thursday', '18:15', 1, 1],
      ['Friday', '19:00', 1, 2],
      ['Friday', '10:45', 1, 1],
      ['Friday', '16:15', 1, 1],
      ['Friday', '18:15', 1, 1],
      ['Saturday', '10:20', 1, 1],
    ].each do |inp|
      cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
      capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    end

    inp = ['Saturday', '10:45', 1, 1]
    cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
    capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    expect(capped_cost).not_to eq(cost)
    expect(capped_cost).to eq(0)
    expect(cost).to eq(25)

    inp = ['Monday', '10:20', 1, 1]
    cost = @fare_matching_service.find_cost(day: inp[0], time: inp[1], from: inp[2], to: inp[3])
    capped_cost = @fare_capping_service.capped_cost(day: inp[0], from: inp[2], to: inp[3], cost: cost)
    expect(capped_cost).to eq(cost)
  end
end
