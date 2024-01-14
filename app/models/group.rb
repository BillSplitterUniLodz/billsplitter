# frozen_string_literal: true

class Group
  include Dynamoid::Document

  table name: :groups, key: :group_uuid, capacity_mode: :on_demand

  range :participant_uuid
  field :name, :string
  field :participant_uuid, :string

  global_secondary_index hash_key: :participant_uuid, range_key: :group_uuid
end
