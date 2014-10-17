module TravelingSalesman
  class MultiSet

    extend Forwardable

    def initialize(list)
      @grouped = Hash.new{|h,k| h[k] = []}
      list.each do |item|
        @grouped[item] << item
      end
    end

    def ==(other)
      other.to_a
      return false unless size == other.size
      other = MultiSet.new(other) unless other.is_a? MultiSet
      grouped = other.grouped
    end

    def_delegators :to_a, :size, :to_s, :sample, :each, :sort_by

    def to_a
      @grouped.values.flatten(1)
    end

    protected

    def grouped
      @grouped
    end

  end
end
