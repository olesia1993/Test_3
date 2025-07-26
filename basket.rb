require_relative 'delivery_calculator'

class Basket
    Product = Struct.new(:code, :price)

    def initialize(products:, pricing_rules:, delivery_calculator:)
        @products = products
        @rules = pricing_rules
        @delivery_calculator = delivery_calculator

        @product_index = products.each_with_index.to_h {|p, i| [p[:code], i]}

        @items = []
    end

    def add(product_code)
        @items << product_code
    end

    # def total
    #     subtotal = 0.0

    #     @items.each do |code|
    #         code_id = @product_index[code]
    #         @buy_status[code_id] = (@buy_status[code_id]+1) % @sell_strategy[code_id].length
    #         multiplier = @sell_strategy[code_id][@buy_status[code_id]]
    #         subtotal += @products[code_id][:price] * multiplier
    #     end

    #     subtotal += delivery_charge(subtotal)
    #     subtotal.floor(2)
    # end

    # private
    # def delivery_charge(subtotal)
    #     @delivery_limits.each_with_index do |limit, i|
    #         next_limit = @delivery_limits[i+1] || Float::INFINITY
    #         return @delivery_costs[i] if subtotal >= limit && subtotal < next_limit
    #     end
    # end

    def total
        grouped = @items.tally
        subtotal = grouped.sum do |code, count|
            product = @products.find {|p| p[:code] == code}
            rule = @rules[code]
            rule.apply(count, product[:price])
        end

        subtotal += @delivery_calculator.charge(subtotal)
        subtotal.floor(2)
    end
end