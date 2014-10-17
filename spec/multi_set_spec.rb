require_relative 'spec_helper'
require 'traveling_salesman/multi_set'
include TravelingSalesman

describe MultiSet do

  let(:items) { [1, 2,2, 3,3,3, 4,4,4,4] }
  let(:reordered_items) { [1,2,3,4, 2,3,4, 3,4, 4] }
  subject { MultiSet.new(items) }

  specify "#==" do
    other = MultiSet.new(reordered_items)
    expect(subject).to eq other
  end

  specify "#to_a" do
    expect(subject.to_a).to match_array items
  end

  specify "#size" do
    expect(subject.size).to eq items.size
  end

  specify "#each" do
    expect(subject.each.to_a).to match_array items
  end

end
