require File.join(Dir.pwd, 'specs/spec_helper')

describe "TimingMatchingService" do
  before :each do
    @timing_matching_service = TimingMatchingService.new
  end

  it "matches peak hours" do
    timing = @timing_matching_service.get_matching_timing_type_identifier(
      day: 'Monday', time: '10:20'
    )
    expect(timing).to eq("peak")
  end

  it "matches with second interval of peak hours - 17:00 to 20:00" do
    timing = @timing_matching_service.get_matching_timing_type_identifier(
      day: 'Thursday', time: '18:20'
    )
    expect(timing).to eq("peak")
  end

  it "matches off peak hours as default" do
    timing = @timing_matching_service.get_matching_timing_type_identifier(
      day: 'Wednesday', time: '11:20'
    )
    expect(timing).to eq("off_peak")
  end

  it "matches peak hours if time is 10:30 and peak hours are 07:00 to 10:30" do
    timing = @timing_matching_service.get_matching_timing_type_identifier(
      day: 'Wednesday', time: '10:30'
    )
    expect(timing).to eq("peak")
  end
end
