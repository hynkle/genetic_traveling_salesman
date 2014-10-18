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

  describe "#on_each_generation" do

    let(:counter) { double }

    it "it sets up a callback that's executed once per generation" do
      expect(counter).to receive(:poke).exactly(number_of_generations).times
      subject.on_each_generation do
        counter.poke
      end

      subject.solve!
    end

    it "yields the population and the generation number" do
      generation_counts = []
      subject.on_each_generation do |population, generation_count|
        expect(population).to be_a Population
        generation_counts << generation_count
      end

      subject.solve!

      expect(generation_counts).to eq (1..number_of_generations).to_a
    end
  end

  describe "#after_completion" do

    let(:counter) { double }

    specify do
      last_generation = nil
      subject.after_completion do |final|
        counter.poke
        last_generation = final
      end
      expect(counter).to receive(:poke).exactly(1).times

      subject.solve!

      expect(last_generation).to eq(subject.last_generation)
    end

  end

end
