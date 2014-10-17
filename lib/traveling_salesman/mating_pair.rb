require 'traveling_salesman/solution'
require 'traveling_salesman/partially_mapped_crossover'

module TravelingSalesman
  class MatingPair

    attr_reader :parent1, :parent2, :brood_size

    def initialize(parent1, parent2, brood_size: )
      raise ArgumentError, 'brood_size must be positive' unless brood_size > 0
      @brood_size = brood_size
      @parent1 = parent1
      @parent2 = parent2
    end

    def children
      return @children if defined? @children
      child_pairs = (@brood_size / 2.0).ceil.times.map{ make_child_pair }
      @children = child_pairs.flatten.sample(brood_size)
    end

    def make_child_pair
      sequences = PartiallyMappedCrossover.apply(parent1.city_sequence,
                                                 parent2.city_sequence)
      sequences.map {|sequence| Solution.new(sequence)}
    end
  end
end
