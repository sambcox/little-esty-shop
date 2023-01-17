class RedundancyValidator < ActiveModel::Validator
  def validate(record)
    if BulkDiscount.where('quantity_threshold <= ?', record.quantity_threshold).where('percentage_discount >= ?', record.percentage_discount).where(merchant_id: record.merchant_id).present?
      record.errors.add :base, 'Redundant discount already exists'
    end
  end
end