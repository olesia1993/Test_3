✅ main.rb
Purpose:
Entry point of the application. This is where you define your product catalog, delivery rules, and pricing rules. You also initialize the basket, add items to it, and print the final total.

Responsibilities:

Setup input data (products, delivery limits/costs, promotions).

Initialize classes (Basket, PricingRules, etc.).

Simulate example baskets.

Print the total cost.

✅ basket.rb
Purpose:
Manages the shopping basket. Handles adding products and calculating the total price using pricing and delivery rules.

Responsibilities:

Tracks added product codes.

Groups product counts.

Applies correct pricing rule per product.

Calculates subtotal and adds delivery charges.

Depends on:

PricingRule classes for product-level discount logic.

DeliveryCalculator for delivery fee logic.

✅ delivery_calculator.rb
Purpose:
Encapsulates the logic to determine delivery charges based on subtotal amount.

Responsibilities:

Accept delivery tiers (e.g. [50, 90]) and associated costs ([4.95, 2.95, 0]).

Return the correct delivery fee based on subtotal.

Keeps delivery logic separate from basket logic (single responsibility principle).

✅ pricing_rules/ folder
Contains all pricing-related classes using the Strategy Pattern, allowing flexible and reusable discount logic per product.

🟨 pricing_rule.rb
Purpose:
Abstract base class or interface for pricing rules.

Responsibilities:

Defines an apply(count, price) method all pricing rules must implement.

Optionally raises NotImplementedError to enforce subclassing.

🟩 no_discount.rb
Purpose:
Simple rule that returns full price without any discount.

Responsibilities:

Used for products that don’t have promotions.

Returns count * price.