require 'traveling_salesman/city'
require 'traveling_salesman/coordinate_pair'

module TravelingSalesman
  class CityDataFile

    attr_reader :cities

    def initialize(path)
      lines = File.readlines(path)
      lines.shift(2)  # the first two lines are headers, so throw them away
      @cities = lines.map {|line| line_to_city(line)}
    end

    def line_to_city(line)
      name, x, y, _ = line.lstrip.split(/\s+/).map(&:strip)
      City.new(name: name, coordinates: CoordinatePair.new(x, y))
    end

  end
end
