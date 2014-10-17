require_relative 'spec_helper'
require 'traveling_salesman/mating_pair'
require 'traveling_salesman/city'
require 'traveling_salesman/solution'
include TravelingSalesman

describe MatingPair do

  let(:cities) {
    9.times.map do |i|
      City.new(name: "City ##{i}", coordinates: instance_double('CoordinatePair'))
    end
  }

  let(:brood_size) { 20 }
  let(:solution1) { Solution.new(cities.shuffle) }
  let(:solution2) { Solution.new(cities.shuffle) }

  let(:subject) { MatingPair.new(solution1, solution2, brood_size: brood_size) }

  describe "#make_child_pair" do

    it "is a pair" do
      expect(subject.make_child_pair.size).to eq(2)
    end

    it "are Solutions" do
      expect(subject.make_child_pair).to all be_a Solution
    end
  end

  describe "#children" do

    it "is of the specified brood size" do
      expect(subject.children.size).to eq(brood_size)
    end

    it "are Solutions" do
      expect(subject.children).to all be_a Solution
    end

    it "doesn't change on subsequent calls" do
      original_children = subject.children
      expect(subject.children).to eq original_children
    end

  end

end
