require_relative 'basket'

products = [
  { code: "R01", price: 32.95 },
  { code: "G01", price: 24.95 },
  { code: "B01", price: 7.95 }
]

delivery_limits = [0, 50, 90]
delivery_costs = [4.95, 2.95, 0]
sell_strategy = [
  [1, 0.5], # R01: buy one, get second half off
  [1],      # G01: no discount
  [1]       # B01: no discount
]

basket = Basket.new(
  products: products,
  delivery_limits: delivery_limits,
  delivery_costs: delivery_costs,
  sell_strategy: sell_strategy
)

["B01", "B01", "R01", "R01", "R01"].each { |code| basket.add(code) }

puts "Total: $#{basket.total}"