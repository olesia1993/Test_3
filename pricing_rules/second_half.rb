require_relative 'pricing_rule'

class SecondHalf < PricingRule
    def apply(count, price) 
        pairs = count / 2
        left_odd = count % 2
        pairs * (price + price * 0.5) + left_odd * price
    end
end