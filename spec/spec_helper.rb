# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
require 'csv'
require 'simplecov'
require 'faker'
SimpleCov.start do
  add_filter 'spec/rails_helper.rb'
end
RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before :suite do
    Merchant.destroy_all
    Item.destroy_all
    Customer.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Transaction.destroy_all
    CSV.foreach('./spec/data/merchants_test.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')

    CSV.foreach('./spec/data/items_test.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')

    CSV.foreach('./spec/data/customers_test.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')

    CSV.foreach('./spec/data/invoices_test.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')

    CSV.foreach('./spec/data/invoice_items_test.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')

    CSV.foreach('./spec/data/transactions_test.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  def bulk_discount_test_seed_scenario_1
    @merchant_1 = Merchant.create!({ name: Faker::Company.name })
    @item_1 = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: Faker::Number.between(from: 100, to: 999999), description: Faker::TvShows::Community.quotes })
    @item_2 = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: Faker::Number.between(from: 100, to: 999999), description: Faker::TvShows::Community.quotes })
    @customer_1 = Customer.create!({ first_name: Faker::Name.first_name, last_name: Faker::Name.last_name })
    @invoice_1 = @customer_1.invoices.create!({ status: ['completed', 'in progress', 'cancelled'].shuffle.first })
    InvoiceItem.create!({ status: ['pending', 'packaged', 'shipped'].shuffle.first, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 5, unit_price: @item_1.unit_price })
    InvoiceItem.create!({ status: ['pending', 'packaged', 'shipped'].shuffle.first, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: @item_2.unit_price })
    @bulk_discount_1 = @merchant_1.bulk_discounts.create!({ quantity_threshold: 10, percentage_discount: 0.2 })
  end

  def bulk_discount_test_seed_scenario_2
    @merchant_1 = Merchant.create!({ name: Faker::Company.name })
    @item_1 = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: Faker::Number.between(from: 100, to: 999999), description: Faker::TvShows::Community.quotes })
    @item_2 = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: Faker::Number.between(from: 100, to: 999999), description: Faker::TvShows::Community.quotes })
    @customer_1 = Customer.create!({ first_name: Faker::Name.first_name, last_name: Faker::Name.last_name })
    @invoice_1 = @customer_1.invoices.create!({ status: ['completed', 'in progress', 'cancelled'].shuffle.first })
    InvoiceItem.create!({ status: ['pending', 'packaged', 'shipped'].shuffle.first, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 10, unit_price: @item_1.unit_price })
    InvoiceItem.create!({ status: ['pending', 'packaged', 'shipped'].shuffle.first, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 5, unit_price: @item_2.unit_price })
    @bulk_discount_1 = @merchant_1.bulk_discounts.create!({ quantity_threshold: 10, percentage_discount: 0.2 })
  end

  def bulk_discount_test_seed_scenario_3
    @merchant_1 = Merchant.create!({ name: Faker::Company.name })
    @item_1 = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: Faker::Number.between(from: 100, to: 999999), description: Faker::TvShows::Community.quotes })
    @item_2 = @merchant_1.items.create!({ name: Faker::Commerce.product_name, unit_price: Faker::Number.between(from: 100, to: 999999), description: Faker::TvShows::Community.quotes })
    @customer_1 = Customer.create!({ first_name: Faker::Name.first_name, last_name: Faker::Name.last_name })
    @invoice_1 = @customer_1.invoices.create!({ status: ['completed', 'in progress', 'cancelled'].shuffle.first })
    InvoiceItem.create!({ status: ['pending', 'packaged', 'shipped'].shuffle.first, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 12, unit_price: @item_1.unit_price })
    InvoiceItem.create!({ status: ['pending', 'packaged', 'shipped'].shuffle.first, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 15, unit_price: @item_2.unit_price })
    @bulk_discount_1 = @merchant_1.bulk_discounts.create!({ quantity_threshold: 10, percentage_discount: 0.2 })
    @bulk_discount_2 = @merchant_1.bulk_discounts.create!({ quantity_threshold: 15, percentage_discount: 0.3 })
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # The settings below are suggested to provide a good initial experience
  # with RSpec, but feel free to customize to your heart's content.
  #   # This allows you to limit a spec run to individual examples or groups
  #   # you care about by tagging them with `:focus` metadata. When nothing
  #   # is tagged with `:focus`, all examples get run. RSpec also provides
  #   # aliases for `it`, `describe`, and `context` that include `:focus`
  #   # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  #   config.filter_run_when_matching :focus
  #
  #   # Allows RSpec to persist some state between runs in order to support
  #   # the `--only-failures` and `--next-failure` CLI options. We recommend
  #   # you configure your source control system to ignore this file.
  #   config.example_status_persistence_file_path = "spec/examples.txt"
  #
  #   # Limits the available syntax to the non-monkey patched syntax that is
  #   # recommended. For more details, see:
  #   #   - http://rspec.info/blog/2012/06/rspecs-new-expectation-syntax/
  #   #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   #   - http://rspec.info/blog/2014/05/notable-changes-in-rspec-3/#zero-monkey-patching-mode
  #   config.disable_monkey_patching!
  #
  #   # Many RSpec users commonly either run the entire suite or an individual
  #   # file, and it's useful to allow more verbose output when running an
  #   # individual spec file.
  #   if config.files_to_run.one?
  #     # Use the documentation formatter for detailed output,
  #     # unless a formatter has already been configured
  #     # (e.g. via a command-line flag).
  #     config.default_formatter = "doc"
  #   end
  #
  #   # Print the 10 slowest examples and example groups at the
  #   # end of the spec run, to help surface which specs are running
  #   # particularly slow.
  #   config.profile_examples = 10
  #
  #   # Run specs in random order to surface order dependencies. If you find an
  #   # order dependency and want to debug it, you can fix the order by providing
  #   # the seed, which is printed after each run.
  #   #     --seed 1234
  #   config.order = :random
  #
  #   # Seed global randomization in this process using the `--seed` CLI option.
  #   # Setting this allows you to use `--seed` to deterministically reproduce
  #   # test failures related to randomization by passing the same `--seed` value
  #   # as the one that triggered the failure.
  #   Kernel.srand config.seed
end
