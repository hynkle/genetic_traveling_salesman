require_relative 'spec_helper'
require 'traveling_salesman/city'
include TravelingSalesman

describe City do

  let(:coordinates) { double('CoordinatePair') }
  subject { City.new(name: 'Atlantis', coordinates: coordinates) }

  it "has a name" do
    expect(subject.name).to eq 'Atlantis'
  end

  it "has coordinates" do
    expect(subject.coordinates).to eq coordinates
  end

  describe "#distance_to" do

    it "calculates distance on a euclidean plane" do
      city1 = City.new(name: 'One', coordinates: double('CoordinatePair', x: 0, y: 0))
      city2 = City.new(name: 'Two', coordinates: double('CoordinatePair', x: 3, y: 4))
      expect(city1.distance_to(city2)).to eq 5
    end

  end

end
