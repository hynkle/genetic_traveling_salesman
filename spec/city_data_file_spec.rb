require_relative 'spec_helper'
require 'traveling_salesman/city_data_file'
include TravelingSalesman

describe CityDataFile do

  before do
    path = File.join(__dir__, 'fixtures', 'TSPDATA.txt')
    @city_data_file = CityDataFile.new(path)
  end

  describe "#cities" do

    it "doesn't miss any cities" do
      @city_data_file.cities.size.must_equal 127
    end

    it "contains actual cities" do
      @city_data_file.cities.first.must_be_kind_of City
    end

  end

end
