class Basket
    Product = Struct.new(:code, :price)

    def initialize(products:, delivery_limits:, delivery_costs:, sell_strategy:)
        @products = products
        @delivery_limits = delivery_limits
        @delivery_costs = delivery_costs
        @sell_strategy = sell_strategy
        @product_index = products.each_with_index.to_h {|p, i| [p[:code], i]}

        @buy_status = Array.new(products.size, -1)
        @items = []
    end

    def add(product_code)
        @items << product_code
    end

    def total
        subtotal = 0.0

        @items.each do |code|
            code_id = @product_index[code]
            @buy_status[code_id] = (@buy_status[code_id]+1) % @sell_strategy[code_id].length
            multiplier = @sell_strategy[code_id][@buy_status[code_id]]
            subtotal += @products[code_id][:price] * multiplier
        end

        subtotal += delivery_charge(subtotal)
        subtotal.floor(2)
    end

    private
    def delivery_charge(subtotal)
        @delivery_limits.each_with_index do |limit, i|
            next_limit = @delivery_limits[i+1] || Float::INFINITY
            return @delivery_costs[i] if subtotal >= limit && subtotal < next_limit
        end
    end

end