require_relative 'spec_helper'
require 'traveling_salesman/tournament'
include TravelingSalesman

describe Tournament do

  let(:three)       { instance_double('Solution', fitness: 3) }
  let(:four)        { instance_double('Solution', fitness: 4) }
  let(:five)        { instance_double('Solution', fitness: 5) }
  let(:five_prime)  { instance_double('Solution', fitness: 5) }

  describe "#fittest" do
    it "is those who tie for greatest fitness" do
      tournament = Tournament.new([three, five, five_prime])
      expect(tournament.fittest).to contain_exactly(five, five_prime)
    end
  end

  describe "#winner" do

    it "is the contestant with the greatest fitness" do
      tournament = Tournament.new([three, four, five])
      expect(tournament.winner).to eq five
    end

    it "picks randomly in case of a tie" do
      tournament = Tournament.new([three, five, five_prime])
      fittest = [five, five_prime]
      expect(tournament).to receive(:fittest).and_return(fittest)
      expect(fittest).to receive(:sample).and_return(five_prime)
      expect(tournament.winner).to eq five_prime
    end

  end

end
