# frozen_string_literal: true

class ExpensesController < ApplicationController
  before_action :find_expense, only: [:show, :destroy, :update]
  before_action :find_group

  def index
    render json: Expenses::Presenter.new(@top_level_group).serialize
  end

  def stats
    render json: Expenses::ExpensesBreakdown.new(@group).calculate
  end

  def show
    render json: @expense.to_h
  end

  def create
    expense = Expense.create(
      expense_params.reverse_merge(
        user_uuid: current_user.user_uuid,
        group_uuid: @group.group_uuid,
        payer_uuids: @group.participant_uuids
      )
    )
    render json: expense.to_h
  end

  def update
    @expense.update_attributes(**expense_params)

    render json: @expense.to_h
  end

  def destroy
    @expense.destroy
    render json: {}, status: :ok
  end

  private

  def expense_params
    params.require(:expense).permit(:user_uuid, :name, :amount, :payer_uuids)
  end

  def find_group
    @group = Group.where(group_uuid: params[:group_uuid], participant_uuid: current_user.user_uuid).first
    @top_level_group = Group.top_level(params[:group_uuid])
  end

  def find_expense
    @expense = Expense.where(group_uuid: params[:group_uuid], expense_uuid: params[:expense_uuid]).first
  end
end
