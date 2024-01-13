class Group
  include Dynamoid::Document

  table name: :groups, key: :group_uuid, capacity_mode: :on_demand

  field :name, :string

  range_key :participant_uuid, :string
end
