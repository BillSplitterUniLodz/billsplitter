class BillingRecord
  def initialize(user_id:, name:, amount:, updated_at: DateTime.now, created_at: DateTime.now, id: SecureRandom.uuid)
    @user_id = user_id
    @name = name
    @amount = amount.to_i
    @id = id
    @updated_at = updated_at
    @created_at = created_at
  end

  def to_h
    {
      user_id: user_id,
      name: name,
      amount: amount, 
      id: id
    }
  end

  def to_json
    to_h.merge(
      amount: amount / 100
    )
  end

  private

  attr_reader :user_id, :name, :amount, :id, :updated_at, :created_at
end
