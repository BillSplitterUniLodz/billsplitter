module Validators
  class UniquenessValidator < ActiveModel::Validator
    def validate(record)
      return unless record.class.where(email: record.email).first

      record.errors.add :email, 'should be unique'
    end
  end
end
