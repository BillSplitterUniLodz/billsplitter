class Expense
  include Dynamoid::Document

  table name: :expenses, key: :expense_uuid, capacity_mode: :on_demand

  field :name

  field :group_uuid, :string
  field :user_uuid, :string

  global_secondary_index hash_key: :group_uuid
  global_secondary_index hash_key: :user_uuid
end
