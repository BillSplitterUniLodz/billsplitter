class GroupsController < ApplicationController
  def index
    render json: Group.where(participant_uuid: current_user.user_uuid).all
  end

  def create
    Group.create(
      group_uuid: SecureRandom.uuid,
      participant: current_user.user_uuid
    )
  end
end
