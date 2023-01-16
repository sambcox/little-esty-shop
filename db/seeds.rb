# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.find(1).bulk_discounts.create!({ quantity_threshold: 10, percentage_discount: 0.2 })
Merchant.find(1).bulk_discounts.create!({ quantity_threshold: 15, percentage_discount: 0.3 })
Merchant.find(2).bulk_discounts.create!({ quantity_threshold: 12, percentage_discount: 0.25 })
Merchant.find(3).bulk_discounts.create!({ quantity_threshold: 5, percentage_discount: 0.1 })
Merchant.find(4).bulk_discounts.create!({ quantity_threshold: 10, percentage_discount: 0.2 })
Merchant.find(5).bulk_discounts.create!({ quantity_threshold: 15, percentage_discount: 0.3 })
Merchant.find(6).bulk_discounts.create!({ quantity_threshold: 12, percentage_discount: 0.25 })
Merchant.find(7).bulk_discounts.create!({ quantity_threshold: 15, percentage_discount: 0.3 })
Merchant.find(8).bulk_discounts.create!({ quantity_threshold: 10, percentage_discount: 0.2 })