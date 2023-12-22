class User
  include Dynamoid::Document
  include BCrypt
  include ActiveModel::Validations

  table name: :user, key: :id, capacity_mode: :on_demand

  field :name, :string
  field :email, :string
  field :password, :string

  global_secondary_index hash_key: :email, projected_attributes: :all

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  validates_with Validators::UniquenessValidator

  def set_password=(new_password)
    password = Password.create(new_password)
    self.password = password
  end

  def compare_password?(other_password)
    Password.new(self.password) == other_password
  end

  def jwt_subject
    id
  end
end
