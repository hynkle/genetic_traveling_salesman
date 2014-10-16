module TravelingSalesman
  module PartiallyMappedCrossover

    MIN_SEGMENT_SIZE_PERCENTAGE = 4
    MAX_SEGMENT_SIZE_PERCENTAGE = 35

    def self.apply(a, b)
      a, b = a.to_a, b.to_a
      raise ArgumentError, "can only combine lists of same size" unless a.size == b.size
      size = a.size

      segment = pick_segment(size)
      segment_indices = segment.map{|i| i % a.size}  # for wraparound

      child_a = pmx(a, b, segment_indices)
      child_b = pmx(b, a, segment_indices)

      [child_a, child_b]
    end

    private

    def self.pick_segment(size)
      min_segment_size = MIN_SEGMENT_SIZE_PERCENTAGE * size / 100.0
      max_segment_size = MAX_SEGMENT_SIZE_PERCENTAGE * size / 100.0
      segment_size = min_segment_size + rand(max_segment_size - min_segment_size + 1)

      start = rand(size).round
      stop = (start + segment_size).round

      start..stop
    end

    def self.pmx(p1, p2, segment_indices)
      child = Array.new(p1.size)
      
      segment_indices.each do |i|
        child[i] = p1[i]
      end

      # bounce-fill with the elements from the segment in p2
      segment_indices.each do |i|
        next if child.include?(p2[i])
        child_index = bounce_lookup(p1, p2, segment_indices, i)
        child[child_index] = p2[i]
      end

      # fill in any gaps by copying over from p2
      child.each.with_index do |item, i|
        next unless item.nil?
        child[i] = p2[i]
      end

      child
    end

    def self.bounce_lookup(p1, p2, segment_indices, i)
      v = p1[i]
      index_in_p2 = p2.index(v)
      if segment_indices.include?(index_in_p2)
        bounce_lookup(p1, p2, segment_indices, index_in_p2)
      else
        index_in_p2
      end
    end

  end
end
