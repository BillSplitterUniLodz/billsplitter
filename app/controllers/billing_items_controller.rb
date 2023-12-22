class BillingRecordsController < ApplicationController
  def index
    BillingRoom.where(user_id: current_user.id).map(&:billing_records).map{ |r| BillingRecord.new(**r) }
  end

  def create
    billing_room = BillingRoom.find(params[:room_id])
    new_billing_record = BillingRecord.new(user_id: current_user.id, name: billing_record_params[:name], amount: billing_record_params[:amount])
    billing_room.update(
      billing_records: billing_room.billing_records.push(new_billing_record.to_h.merge(created_at: DateTime.now))
    )
  end

  def update
    billing_room = BillingRoom.find(params[:room_id])
    record_to_update = bililng_room.billing_records.delete! { |br| br.id == praams[:id] }
    record_to_update.merge(**billing_record_params)
    billing_room.billing_records.push(record_to_update.to_h.merge(updated_at: DateTime.now))
  end

  def destroy
  end

  def billing_record_params
    params.require(:billing_record).permit(:name, :amount)
  end
end
