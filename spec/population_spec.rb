require_relative 'spec_helper'
require 'traveling_salesman/population'
require 'traveling_salesman/mating_pair'
include TravelingSalesman

describe Population do

  let(:cities) { 3.times.map{|i|instance_double('City', distance_to: 3, name: i)} }
  let(:solutions) { Population::SIZE.times.map { instance_double('Solution') } }

  describe "#new" do
    it "sets solutions" do
      population = Population.new(solutions)
      expect(population.solutions).to eq solutions
    end
  end

  describe ".initial" do
    it "builds a population of random solutions" do
      expect(cities).to receive(:shuffle).exactly(Population::SIZE).times.and_call_original
      population = Population.initial(cities)
      expect(population.solutions.size).to eq Population::SIZE
    end
  end

  describe '#pick_parents' do
    subject { Population.initial(cities) }
    let(:parents) { subject.solutions.sample(2) }
    let(:parent1) { parents[0] }
    let(:parent2) { parents[1] }
    let(:tournament1) { instance_double('Tournament', winner: parent1) }
    let(:tournament2) { instance_double('Tournament', winner: parent1) }

    it "is two solutions" do
      picked_parents = subject.pick_parents
      expect(picked_parents.size).to eq 2
      expect(picked_parents).to all be_a Solution
    end

    it "runs a tournament" do
      expect(subject).to receive(:pick_tournament_competitors).exactly(2).times
      expect(Tournament).to receive(:new).and_return(tournament1, tournament2)
      expect(tournament1).to receive(:winner).and_return(parent1)
      expect(tournament2).to receive(:winner).and_return(parent2)

      expect(subject.pick_parents).to eq parents
    end
  end

  describe '#displace_weakest_with' do
    let(:solutions) do
      (0...Population::SIZE).map do |i|
        instance_double('Solution', fitness: i)
      end
    end

    let(:new_solutions) do
      2.times.map { instance_double('Solution', fitness: 9999) }
    end

    let(:subject) { Population.new(solutions) }

    specify do
      subject.displace_weakest_with(new_solutions)

      expected_fitnesses = solutions.map do |solution|
        solution.fitness > 1 ? solution.fitness : 9999
      end

      expect(subject.solutions.map(&:fitness)).to match_array expected_fitnesses
    end

  end

  describe "#successor" do

    subject { Population.initial(cities) }
    let(:parents) { subject.solutions.sample(2) }
    let(:mating_pair) { MatingPair.new(*parents, brood_size: 1) }
    let(:children) { [instance_double('Solution')] }
    let(:successor) { Population.new(subject.solutions) }

    specify do
      expect(Population).to receive(:new).with(subject.solutions).and_return(successor)
      expect(successor).to receive(:pick_parents).and_return(parents)
      expect(MatingPair).to receive(:new).with(parents[0], parents[1], brood_size: 1).and_return(mating_pair)
      expect(mating_pair).to receive(:children).and_return(children)
      children.each {|child| expect(child).to receive(:mutate!)}
      expect(successor).to receive(:displace_weakest_with).with(children).and_call_original

      expect(subject.successor).to be_a Population
    end

  end

  describe "#dup" do

    it "produces an equivalent but non-identical Population" do
      original = Population.initial(cities)
      duped = original.dup

      expect(duped).to eq original
      expect(duped).not_to be original
    end

  end

  describe "#==" do
    it "is independent of the order of the solutions" do
      alpha = Population.new(solutions)
      beta  = Population.new(solutions.rotate)
      expect(alpha).to eq beta
    end
  end

end
