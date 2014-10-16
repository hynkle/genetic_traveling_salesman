require_relative 'spec_helper'
require 'traveling_salesman/coordinate_pair'
include TravelingSalesman

describe CoordinatePair do

  subject { CoordinatePair.new(-1, 3) }

  it "has an x coordinate" do
    expect(subject.x).to eq -1
  end

  it "has a y coordinate" do
    expect(subject.y).to eq 3
  end

end
