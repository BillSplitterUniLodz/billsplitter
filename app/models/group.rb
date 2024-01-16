# frozen_string_literal: true

class Group
  include Dynamoid::Document

  table name: :groups, key: :group_uuid, capacity_mode: :on_demand

  range :participant_uuid
  field :name, :string
  field :participant_uuid, :string
  field :top_level, :boolean

  global_secondary_index hash_key: :participant_uuid, range_key: :group_uuid

  def self.groups_by_participant(uuid)
    where(participant_uuid: uuid).map do |g| 
      where(group_uuid: g.group_uuid).to_a
    end.flatten
  end

  def all_groups
    Group.where(group_uuid: self.group_uuid).to_a
  end


  def self.top_level(uuid)
    where(group_uuid: uuid).to_a.detect{ |g| g.top_level }
  end

  def invite(participant_uuid)
    Group.create(
      participant_uuid: participant_uuid, 
      group_uuid: self.group_uuid,
      top_level: false, 
      name: self.name
    )
  end

  def to_h
    attributes
  end

  def to_json(*_args)
    to_h.to_json
  end
end
