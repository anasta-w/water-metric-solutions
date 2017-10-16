require 'rails_helper'

RSpec.describe SensorData do

  it "raises an ArgumentError when is_online? is called with no args" do
    expect{ SensorData.is_online? }.to raise_error(ArgumentError)
  end

  it "should only accept a string as a parameter for is_online?" do
    expect (SensorData.is_online?)
  end

end
