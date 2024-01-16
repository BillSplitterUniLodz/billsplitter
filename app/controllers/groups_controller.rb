# frozen_string_literal: true

class GroupsController < ApplicationController
  def index
    groups = Group.groups_by_participant(current_user.user_uuid)

    render json: Groups::Presenter.new(groups).serialize.to_json
  end

  def show
    groups = Group.top_level(params[:group_uuid]).all_groups

    render json: Groups::Presenter.new(groups).serialize.to_json
  end

  def create
    group = Group.create(
      group_uuid: SecureRandom.uuid,
      participant_uuid: current_user.user_uuid,
      top_level: true,
      **group_params
    )
    render json: Groups::Presenter.new([group]).serialize.to_json
  end

  def generate_invite
    group_id = params[:group_uuid]
    token = TokenService.generate_token(group_id)
    
    render json: { token: token }
  end

  def process_invite
    decoded_token = TokenService.decode_token(params[:token]).with_indifferent_access
    group = Group.top_level(decoded_token[:group_uuid])
    new_group = group.invite(current_user.user_uuid)

    render json: Groups::Presenter.new(group.all_groups).serialize.to_json
  end

  def update
    groups = Group.top_level(params[:group_uuid]).all_groups
    groups.each { |group| group.update_attributes(group_params) }

    render json: Groups::Presenter.new(groups).serialize.to_json
  end

  def destroy
    groups = Group.top_level(params[:group_uuid]).all_groups
    groups.each { |group| group.destroy }

    render json: { destroyed: true }
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
