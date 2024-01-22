# frozen_string_literal: true

class Expense
  include Dynamoid::Document

  table name: :expenses, key: :expense_uuid, capacity_mode: :on_demand

  field :amount, :integer
  field :payer_uuids, :array
  field :name

  field :group_uuid, :string
  field :user_uuid, :string

  global_secondary_index hash_key: :group_uuid
  global_secondary_index hash_key: :user_uuid

  def self.by_group_uuid(group_uuid)
    Expense.where(group_uuid: group_uuid).all
  end

  def amount
    Money.from_cents(attributes[:amount])
  end

  def deposit?
    amount.positive?
  end

  def credit?
    amount.negative?
  end

  def to_h
    attributes.merge(amount_display: Money.from_cents(amount).format)
  end
end
