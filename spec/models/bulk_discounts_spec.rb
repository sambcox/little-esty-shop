require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'Relationships' do
    it { should belong_to :merchant }
  end

  describe 'Validations' do
    it { should validate_numericality_of :quantity_threshold }
    it { should validate_presence_of :percentage_discount }
    it { should validate_numericality_of(:percentage_discount).is_less_than(1) }
  end
end