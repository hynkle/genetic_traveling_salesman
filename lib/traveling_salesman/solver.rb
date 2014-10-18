require 'traveling_salesman/population'

module TravelingSalesman
  class Solver

    attr_reader :generations

    def initialize(cities: , generations: )
      @cities = cities
      @number_of_generations = generations
      @generations = []
    end

    def solve!
      generations << Population.initial(@cities)
      2.upto(@number_of_generations) do |generation_number|
        generations << last_generation.successor
      end
    end

    def last_generation
      generations.last
    end

  end
end
