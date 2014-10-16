module TravelingSalesman
  class CircularList

    include Enumerable

    def initialize(array)
      @array = array.dup
    end

    def slice(*args)
      case args.size
      when 1
        arg = args.first
        case arg
        when Numeric then @array[normalize_index(arg)]
        when Range
          raise ArgumentError, 'slice cannot be longer than the list' if arg.size > size
          arg.map {|i| @array[normalize_index(i)]}
        else raise ArgumentError, "expected Numeric or Range"
        end
      when 2
        start, length = args
        finish = start + length - 1
        slice(start..finish)
      else raise ArgumentError, "wrong number of arguments (#{args.size} for 1..2)"
      end
    end

    alias_method :[], :slice

    def []=(*args)
      assignment_value = args.pop
      slice_args = args
      case slice_args.size
      when 1
        arg = slice_args.first
        case arg
        when Numeric then @array[normalize_index(arg)] = assignment_value
        when Range
          range = arg
          @array = @array.rotate(range.begin)
          upper = range.exclude_end?
          range = (0...range.size)
          @array[range] = assignment_value
        else raise ArgumentError, "expected Numeric or Range"
        end
      when 2
        start, length = slice_args
        finish = start + length - 1
        self[start..finish] = assignment_value
      else raise ArgumentError, "wrong number of arguments (#{slice_args.size} for 1..2)"
      end
    end

    def size
      @array.size
    end

    def each(&block)
      @array.each(&block)
    end

    def each_cons(n)
      raise ArgumentError, 'invalid size' unless (1...size).cover? n
      Enumerator.new do |yielder|
        size.times do |offset|
          yielder << @array.rotate(offset).take(n)
        end
      end
    end

    def ==(other)
      other = other.to_a
      return false unless size == other.size
      rotations = 0.upto(size-1).lazy.map {|i| @array.rotate(i) }
      rotations.any? {|rotation| rotation == other}
    end

    def eql?(other)
      self == other
    end

    def hash
      # pretty high collision rate for this hash function...
      "CircularList of size #{size}".hash
    end

    def inspect
      "#<CircularList [#{@array.map(&:inspect).join(', ')}]>"
    end

    private

    def normalize_index(index)
      index % size
    end

  end
end
