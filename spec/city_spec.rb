require_relative 'spec_helper'
require 'traveling_salesman/city'
include TravelingSalesman

describe City do

  before do
    @coordinates = mock('coordinate_pair') 
    @city = City.new(name: 'Atlantis', coordinates: @coordinates)
  end

  it "has a name" do
    @city.name.must_equal 'Atlantis'
  end

  it "has coordinates" do
    @city.coordinates.must_equal @coordinates
  end

  describe "#distance_to" do

    it "calculates distance on a euclidean plane" do
      city1 = City.new(name: 'One', coordinates: Struct.new(:x, :y).new(0, 0))
      city2 = City.new(name: 'Two', coordinates: Struct.new(:x, :y).new(3, 4))
      city1.distance_to(city2).must_equal 5
    end

  end

end
