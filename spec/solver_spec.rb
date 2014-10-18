require_relative 'spec_helper'
require 'traveling_salesman/solver'
require 'traveling_salesman/city'
require 'traveling_salesman/population'
include TravelingSalesman

describe Solver do

  let(:cities) {
    5.times.map do |i|
      coordinates = instance_double('CoordinatePair', x: i, y: i)
      City.new(name: i, coordinates: coordinates)
    end
  }
  let(:number_of_generations) { 10 }

  subject { Solver.new(cities: cities, generations: number_of_generations) }

  describe "#solve!" do
    it "runs the proper number of generations" do
      subject.solve!
      expect(subject.generations.size).to eq number_of_generations
    end
  end

  describe "#generations" do
    specify do
      subject.solve!
      expect(subject.generations).to all be_a Population
    end
  end

end
