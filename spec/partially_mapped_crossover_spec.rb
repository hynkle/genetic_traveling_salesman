require_relative 'spec_helper'
require 'traveling_salesman/partially_mapped_crossover'
include TravelingSalesman

describe PartiallyMappedCrossover do

  describe "#apply" do

    subject { PartiallyMappedCrossover.apply(list_a, list_b) }
    let(:children) { [child1, child2] }
    before do
      expect(PartiallyMappedCrossover).to receive(:pick_segment).and_return(segment)
    end

    context do
      let(:segment) { 4..7 }
      let(:list_a) { [1,2,3,  4,5,6,7,  8,9] }
      let(:list_b) { [4,5,2,  1,8,7,6,  9,3] }
      let(:child1) { [4,9,2,  1,5,6,7,  8,3] }
      let(:child2) { [1,2,3,  4,8,7,6,  9,5] }

      specify do
        expect(subject).to eq children
      end
    end

    context do
      let(:segment) { 4..9 }
      let(:list_a) { [9,  6,5,2, 7,8,1,3,4] }
      let(:list_b) { [1,  3,5,8, 7,2,4,9,6] }
      let(:child1) { [9,  6,5,2, 7,8,1,3,4] }
      let(:child2) { [1,  3,5,8, 7,2,4,9,6] }

      specify do
        expect(subject).to eq children
      end
    end

    context do
      let(:segment) { 8..10 }
      let(:list_a) { [3,9,  1,5,7,4,6,2,  8] }
      let(:list_b) { [5,6,  1,3,4,7,8,9,  2] }
      let(:child1) { [3,9,  1,5,4,7,2,6,  8] }
      let(:child2) { [5,6,  1,3,7,4,9,8,  2] }

      specify do
        expect(subject).to eq children
      end
    end

    context do
      let(:segment) { 8..10 }
      let(:list_a) { [1,2,  6,4,8,9,5,3,  7] }
      let(:list_b) { [2,6,  4,8,9,5,3,7,  1] }
      let(:child1) { [1,2,  4,8,9,5,3,6,  7] }
      let(:child2) { [2,6,  7,4,8,9,5,3,  1] }

      specify do
        expect(subject).to eq children
      end
    end
  end

end
