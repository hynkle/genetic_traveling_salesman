require_relative 'spec_helper'
require 'traveling_salesman/circular_list'
include TravelingSalesman

describe CircularList do

  describe "#slice" do

    subject { CircularList.new(%w(apple banana cherry dragonfruit elderberry)) }

    describe "with a numeric index" do

      it "indexes like an array" do
        expect(subject.slice(1)).to eq 'banana'
      end

      it "has wraparound indexing for positive indices" do
        expect(subject.slice(5)).to eq 'apple'
      end

      it "has wraparound indexing for negative indices" do
        expect(subject.slice(-1)).to eq 'elderberry'
      end

    end

    describe "with a range" do

      it "gets the corresponding elements" do
        expect(subject.slice(1..2)).to eq %w(banana cherry)
      end

      it "wraps around the end" do
        expect(subject.slice(4..6)).to eq %w(elderberry apple banana)
      end

      it "disallows too big a range" do
        expect{subject.slice(0..5)}.to raise_error ArgumentError, 'slice cannot be longer than the list'
      end

      it "is empty for an empty range" do
        expect(subject.slice(4..2)).to be_empty
      end

    end

    describe "with start and length" do

      it "gets the corresponding elements" do
        expect(subject.slice(1, 3)).to eq %w(banana cherry dragonfruit)
      end

      it "wraps around the end" do
        expect(subject.slice(4, 3)).to eq %w(elderberry apple banana)
      end

      it "disallows too big a length" do
        expect{subject.slice(2, 6)}.to raise_error ArgumentError, 'slice cannot be longer than the list'
      end

    end
  end

  describe "#[]=" do

    subject { CircularList.new(%w(apple banana cherry dragonfruit elderberry)) }

    describe "with a numeric index" do

      it "behaves like slice" do
        subject[2] = 'clementine'
        expect(subject.slice(2)).to eq 'clementine'
      end

      it "behaves like slice when overlarge and positive" do
        subject[9999] = 'tutti frutti'
        expect(subject.slice(9999)).to eq 'tutti frutti'
      end

      it "behaves like slice when negative" do
        subject[-1] = 'eigenberry'
        expect(subject.slice(-1)).to eq 'eigenberry'
      end

      it "treats arrays like single objects" do
        subject[1] = [1,2,3]
        expect(subject.slice(1)).to eq [1,2,3]
      end

    end

    describe "with start and length" do

      subject { CircularList.new([0,1,2,3,4,5,6,7,8,9]) }

      specify "with an array" do
        subject[8, 5] = %w(a c)
        expect(subject).to eq [3,4,5,6,7,'a','c']
      end

      specify "with a non-array" do
        subject[8, 5] = 'a'
        expect(subject).to eq [3,4,5,6,7,'a']
      end

    end

    describe "with a range" do

      subject { CircularList.new(%w(terrible horrible no good day)) }

      it "can remove elements" do
        subject[(1..3)] = %w(monstrous)
        expect(subject).to eq %w(terrible monstrous day)
      end

      it "can replace elements" do
        subject[(1..3)] = %w(awful ugly gross)
        expect(subject).to eq %w(terrible awful ugly gross day)
      end

      it "can add elements" do
        subject[(1..3)] = %w(things have happened to me this)
        expect(subject).to eq %w(terrible things have happened to me this day)
      end

      it "can assign a non-list" do
        subject[(1..3)] = 'monstrous'
        expect(subject).to eq %w(terrible monstrous day)
      end

      it "can take endpoint-exclusive ranges" do
        subject[(1...3)] = %w(but kinda sweet)
        expect(subject).to eq %w(terrible but kinda sweet good day)
      end

    end


  end

  describe "#size" do
    it "is the number of elements" do
      expect(CircularList.new([1,2,3]).size).to eq 3
    end
  end

  describe "#each_cons" do

    subject { CircularList.new([1,2,3,4,5]) }

    it "wraps around the underlying array" do
      expect(subject.each_cons(2).to_a).to eq [
        [1, 2],
        [2, 3],
        [3, 4],
        [4, 5],
        [5, 1]
      ]
    end

    it "rejects negative cons sizes" do
      expect { subject.each_cons(-1) }.to raise_error ArgumentError, 'invalid size' 
    end

    it "rejects cons size of 0" do
      expect { subject.each_cons(0) }.to raise_error ArgumentError, 'invalid size' 
    end

    it "rejects cons sizes greater than the list's" do
      expect { subject.each_cons(6) }.to raise_error ArgumentError, 'invalid size' 
    end
  end

  describe "#==" do

    it "matches any rotation" do
      a = CircularList.new([1,2,3,4])
      b = CircularList.new([3,4,1,2])
      expect(a).to eq b
    end

    it "doesn't match a reversal" do
      a = CircularList.new([1,2,3,4])
      b = CircularList.new([4,3,2,1])
      expect(a).not_to eq b
    end

  end

  describe "used as a hash key" do
    
    specify do
      hash = {}
      hash[CircularList.new([1,2,3,4])] = 'foo'
      hash[CircularList.new([1,2,3,4])] = 'bar'
      expect(hash.size).to eq 1
    end

    specify do
      hash = {}
      hash[CircularList.new([1,2,3,4])] = 'foo'
      hash[CircularList.new([4,1,2,3])] = 'bar'
      expect(hash.size).to eq 1
    end

    specify do
      hash = {}
      hash[CircularList.new([1,2,3,4])] = 'foo'
      hash[CircularList.new([4,3,2,1])] = 'bar'
      expect(hash.size).to eq 2
    end

  end

end
