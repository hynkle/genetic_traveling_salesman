module TravelingSalesman
  class City

    attr_reader :name, :coordinates

    def initialize(name:, coordinates: )
      @name = name
      @coordinates = coordinates
    end

    def distance_to(other)
      dx = other.x - x
      dy = other.y - y
      Math.sqrt(dx**2 + dy**2)
    end

    def x
      coordinates.x
    end

    def y
      coordinates.y
    end

    def inspect
      "#<City #{name}>"
    end

  end
end
