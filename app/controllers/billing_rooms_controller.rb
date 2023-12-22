class BillingRoomsController < ApplicationController
  def index
    render json: BillingRoom.where(user_id: current_user.id)
  end

  def create
    billing_room = BillingRoom.create(
      user_id: current_user.id,
      name: billing_room_params[:name],
      users: [{id: current_user.id}]
      billing_records: []
    )

    render json: billing_room.to_h
  end

  def update
    billing_room = BillingRoom.find(params[:id])
    render_access_denied unless billing_room.users.includes?(current_user.id)
    billing_room.update(billing_room_params)
    render json: billing_room.to_h
  end

  def destroy
    billing_room = BillingRoom.find(params[:id])
    render_access_denied unless billing_room.users.includes?(current_user.id)

    billing_room.destroy
    head :ok
  end

  def invite

  end

  private

  def billing_room_params
    params.require(:billing_room).permit(:name)
  end
end
