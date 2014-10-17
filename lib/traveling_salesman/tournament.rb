module TravelingSalesman
  class Tournament

    def initialize(competitors)
      @competitors = competitors  
    end

    def winner
      fittest.sample
    end

    def fittest
      competitors_by_fitness = @competitors.group_by(&:fitness)
      greatest_fitness = competitors_by_fitness.keys.max
      competitors_by_fitness[greatest_fitness]
    end

  end
end
