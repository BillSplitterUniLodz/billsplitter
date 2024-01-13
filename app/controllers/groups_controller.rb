class GroupsController < ApplicationController
  def index
    render json: Group.find(participant_uuid: current_user.user_uuid) 
  end

  def create
    Group.create(
      group_uuid: SecureRandom.uuid,
      participant_uuid: current_user.user_uuid, 
      name: params[:name]
    )
  end
end
