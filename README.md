# ext-domain-model
Info 449 Assignment

- Copy the code to a new project

- Implement the CustomStringConvertible protocol on all types

define a "description" property of type String
this property should return a human-readable version of the contents
for example, Money should return "EUR22.0" (for amount 22.0 and currency EUR)
- Unit tests!

- Define a new protocol: Mathematics

mathematical operation methods (+, -)
define it on Money
write tests to verify that we can add and remove Money
- Unit tests!

- Use an extension to extend Double

add four new extension properties, USD, EUR, GBP, YEN
each should return a Money
each should convert the Double into a Money using "self" as the amount
- Unit tests!
