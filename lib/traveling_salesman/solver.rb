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
      on_generation_callback.call(last_generation, generations.size)
      2.upto(@number_of_generations) do |generation_number|
        successor = last_generation.successor
        generations << successor
        on_generation_callback.call(successor, generations.size)
      end
      after_completion_callback.call(last_generation)
    end

    def last_generation
      generations.last
    end

    def on_each_generation(&block)
      @on_generation_callback = block
    end

    def after_completion(&block)
      @after_completion_callback = block
    end

    private
    
    def on_generation_callback
      @on_generation_callback ||= Proc.new{}
    end

    def after_completion_callback
      @after_completion_callback ||= Proc.new{}
    end

  end
end
