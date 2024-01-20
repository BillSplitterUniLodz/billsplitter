module Expenses
  class ExpensesBreakdown
    def initialize(group)
      @group = group
      @expenses = Expense.by_group_uuid(group.group_uuid).to_a
      @user_uuids = group.participant_uuids
      @users = user_uuids.map { |uuid| User.find(uuid) }
    end

    def calculate
      balance = initialize_balance

      process_expenses(balance)
    end

    private

    attr_reader :group, :expenses, :user_uuids, :users

    def initialize_balance
      balance = {}

      users.each do |user|
        balance[user.user_uuid] = {}
        users.each do |debtor|
          balance[user.user_uuid][debtor.user_uuid] = Money.from_cents(0)
        end
      end
      balance
    end

    def process_expenses(balance)
      expenses.each do |expense|
        if expense.deposit?
          balance[expense.payer_uuids.first][expense.user_uuid] += expense.amount
        else
          debtors = expense.payer_uuids
          amount_per_debtor = expense.amount / debtors.count
          debtors.each do |d|
            balance[expense.user_uuid][d] += amount_per_debtor
          end
        end
      end

      balance
    end
  end
end
