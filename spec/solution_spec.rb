require_relative 'spec_helper'
require 'traveling_salesman/solution'
require 'traveling_salesman/city'
require 'traveling_salesman/coordinate_pair'
include TravelingSalesman

describe Solution do

  let(:city1) {City.new(name: 'One',   coordinates: CoordinatePair.new(0, 0)) }
  let(:city2) {City.new(name: 'Two',   coordinates: CoordinatePair.new(3, 4)) }
  let(:city3) {City.new(name: 'Three', coordinates: CoordinatePair.new(9, 12))}
  let(:cities) { [city1, city2, city3] }

  subject { Solution.new(cities) }

  describe "#pairwise_distances" do
    it "is the distances between each pair of adjacent cities, " \
       "including from the last back to the first" do
      expect(subject.pairwise_distances).to eq [5, 10, 15]
    end
  end

  describe "#overall_distance" do
    it "is the total distance along the path" do
      expect(subject.overall_distance).to eq 30
    end
  end

  describe ".random" do
  
    let(:shuffled_cities) { [city2, city1, city3] }
    subject { Solution.random(cities) }

    it "shuffles the cities into city_sequence" do
      expect(cities).to receive(:shuffle).and_return(shuffled_cities)
      expect(subject.city_sequence).to eq shuffled_cities
    end

  end

  describe "#city_sequence" do
    it "is enumerable" do
      expect(subject.city_sequence).to be_kind_of Enumerable
    end
  end

  describe "#fitness" do
    it "is higher when overall_distance is shorter" do
      longer = Solution.new([])
      shorter = Solution.new([])
      expect(longer).to receive(:overall_distance).and_return(5)
      expect(shorter).to receive(:overall_distance).and_return(3)
      expect(shorter.fitness).to be > longer.fitness
    end
  end

  describe "#mutate!" do
    let(:cities_by_number) do
      Hash.new {|hash, key| hash[key] = instance_double('City', name: key) }
    end

    let(:cities) { (0..15).map{|i| cities_by_number[i]} }

    it "reverses a segment of the route" do
      expect(subject).to receive(:pick_mutation_start).and_return(14)
      expect(subject).to receive(:pick_mutation_length).and_return(4)
      subject.mutate!

      expected_order = [15, 14] + (2..13).to_a + [1, 0]
      expected = expected_order.map {|i| cities_by_number[i]}

      expect(subject.city_sequence).to eq expected
    end
  end

  describe "used as a hash key" do
    
    specify do
      hash = {}
      hash[Solution.new([1,2,3,4])] = 'foo'
      hash[Solution.new([1,2,3,4])] = 'bar'
      expect(hash.size).to eq 1
    end

    specify do
      hash = {}
      hash[Solution.new([1,2,3,4])] = 'foo'
      hash[Solution.new([4,1,2,3])] = 'bar'
      expect(hash.size).to eq 1
    end

    specify do
      hash = {}
      hash[Solution.new([1,2,3,4])] = 'foo'
      hash[Solution.new([4,3,2,1])] = 'bar'
      expect(hash.size).to eq 2
    end

  end

end
