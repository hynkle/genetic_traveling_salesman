require_relative 'spec_helper'
require 'traveling_salesman/coordinate_pair'
include TravelingSalesman

describe CoordinatePair do

  before do
    @coordinate_pair = CoordinatePair.new(-1, 3)
  end

  it "has an x coordinate" do
    @coordinate_pair.x.must_equal -1
  end

  it "has a y coordinate" do
    @coordinate_pair.y.must_equal 3
  end

end
