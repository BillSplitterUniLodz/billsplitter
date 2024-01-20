# frozen_string_literal: true

module Groups
  class Presenter
    def initialize(groups)
      @groups = groups.group_by(&:group_uuid)
    end

    def serialize
      groups.map do |_group_uuid, local_groups|
        top_level_group = local_groups.detect(&:top_level)
        {
          uuid: top_level_group.group_uuid,
          name: top_level_group.name,
          created_at: top_level_group.created_at,
          updated_at: top_level_group.updated_at,
          participants: local_groups.map { |g| User.find(g.participant_uuid).to_h }
        }
      end
    end

    private

    attr_reader :groups
  end
end
