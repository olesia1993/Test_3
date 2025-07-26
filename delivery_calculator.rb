class DeliveryCalculator
    def initialize (limits, costs)
        @limits = limits
        @costs = costs
    end

    def charge(subtotal)
        @limits.each_with_index do |limit, i|
            next_limit = @limits[i+1] || Float::INFINITY
            return @costs[i] if subtotal >= limit && subtotal < next_limit
        end
    end
end