class BillingRoom
  include Dynamoid::Document

  table name: :billing_room, key: :id, capacity_mode: :on_demand

  field :user_id, :string
  field :name, :string
  field :billing_records, :array
  field :users, :array

  global_secondary_index hash_key: :user_id, projected_attributes: :all
end
