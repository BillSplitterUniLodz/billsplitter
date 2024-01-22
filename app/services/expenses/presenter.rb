module Expenses
  class Presenter
    def initialize(group)
      @group = group
      @expenses = Expense.by_group_uuid(group.group_uuid).to_a
      @user_uuids = group.participant_uuids
      @users = user_uuids.map { |uuid| User.find(uuid) }
    end

    def serialize
      {
        group: Groups::Presenter.new([group]).serialize,
        expenses: expenses.map(&:to_h)
      }
    end

    private

    attr_reader :group, :expenses, :user_uuids, :users
  end
end
