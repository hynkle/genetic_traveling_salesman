require 'traveling_salesman/solution'
require 'traveling_salesman/tournament'
require 'traveling_salesman/multi_set'
require 'traveling_salesman/mating_pair'

module TravelingSalesman
  class Population

    SIZE = 10

    attr_reader :solutions

    def initialize(solutions)
      @solutions = MultiSet.new(solutions)
    end

    def self.initial(cities)
      solutions = SIZE.times.map { Solution.random(cities) }
      Population.new(solutions)
    end

    def successor
      successor = self.dup

      parents = MatingPair.new(*successor.pick_parents, brood_size: 1)
      children = parents.children
      
      children.each(&:mutate!)
      successor.displace_weakest_with(children)
      successor
    end

    def fittest
      solutions.to_a.max_by(&:fitness)
    end

    def dup
      Population.new(solutions)
    end

    def pick_parents
      2.times.map do
        competitors = pick_tournament_competitors
        Tournament.new(competitors).winner
      end
    end

    def displace_weakest_with(others)
      raise ArgumentError, "can't displace with a longer array" if others.size > solutions.size
      keepers = solutions.sort_by(&:fitness).drop(others.size)
      @solutions = keepers.concat(others)
    end

    def ==(other)
      return false unless other.respond_to? :solutions
      solutions == other.solutions
    end

    private

    def pick_tournament_competitors
      solutions.sample(2)
    end

  end
end
