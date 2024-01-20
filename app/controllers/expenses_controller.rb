class ExpensesController
  before_action :find_expense, only: [:show, :destroy, :update]
  def index
    expenses = Expense.where(group_uuid: params[:group_uuid]).to_a

    render json: Expenses::Presenter.new(expenses).serialize)
  end

  def stats

  end

  def show
    render json: Expenses::Presenter.new([@expense]).serialize
  end

  def create
    expense = Expense.create(
      expense_params.reverse_merge(
        user_uuid: current_user.user_uuid,
        receiver_uuids: User.users_uuids_by_group_uuid(@group.group_uuid)
      )
    )
  end

  def update
    @expense.update_attributes(**expense_params)

    render json: Expenses::Presenter.new([@expense]).serialize
  end

  def destroy
    @expense.destroy
    render json: {}, status: :ok
  end


  private

  def expense_params
    params.require(:expense).permit(:group_uuid, :user_uuid, :name, :amount, :receiver_uuids)
  end

  def find_expense
    @group = Group.where(group_uuid: params[:group_uuid], participant_uuid: current_user.user_uuid)
    @top_level_group = Group.top_level(group_uuid: params[:group_uuid])
    @expense = Expense.where(group_uuid: params[:group_uuid], expense_uuid: params[:expense_uuid])
  end
end
