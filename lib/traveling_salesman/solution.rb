require 'traveling_salesman/circular_list'

module TravelingSalesman
  class Solution

    MAX_MUTATION_PERCENTAGE = 7
    MIN_MUTATION_PERCENTAGE = 13

    def self.random(cities)
      Solution.new(cities.shuffle)
    end

    def city_sequence
      @sequence
    end

    def initialize(city_sequence)
      @sequence = CircularList.new(city_sequence)
    end

    def pairwise_distances
      city_sequence.each_cons(2).map {|a, b| a.distance_to(b)}
    end

    def overall_distance
      pairwise_distances.inject(:+)
    end

    def fitness
      -overall_distance
    end

    # reverse a segment of the route
    def mutate!
      start = pick_mutation_start
      length = pick_mutation_length
      @sequence[start, length] = @sequence[start, length].reverse
    end

    def ==(other)
      city_sequence == other.city_sequence
    end

    def eql?(other)
      self == other
    end

    def hash
      city_sequence.hash
    end

    private

    def size
      @sequence.size
    end

    def pick_mutation_start
      rand(size)
    end

    def pick_mutation_length
      min_length = (MIN_MUTATION_PERCENTAGE * size / 100.0).round
      max_length = (MAX_MUTATION_PERCENTAGE * size / 100.0).round
      rand(max_length - min_length + 1) + min_length
    end

  end
end
