module TravelingSalesman
  class CoordinatePair

    attr_reader :x, :y

    def initialize(x, y)
      @x = Float(x)
      @y = Float(y)
    end

  end
end
