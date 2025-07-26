require_relative 'pricing_rule'

class NoDiscount < PricingRule
    def apply(count, price)
        count * price
    end
end