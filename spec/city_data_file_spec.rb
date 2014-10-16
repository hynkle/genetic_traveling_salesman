require_relative 'spec_helper'
require 'traveling_salesman/city_data_file'
include TravelingSalesman

describe CityDataFile do

  subject do
    @city_data_file = CityDataFile.new(tspdata_path)
  end

  describe "#cities" do

    it "doesn't miss any cities" do
      expect(subject.cities.size).to eq(127)
    end

    it "contains actual cities" do
      expect(subject.cities).to all be_a(City)
    end

  end

end
