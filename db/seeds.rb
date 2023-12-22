# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# rake dynamoid:create_tables
user = User.create(
  id: SecureRandom.uuid,
  name: "Andriy",
  password: BCrypt::Password.create('123qwe'),
  email: 'rewrite.andriy@gmail.com'
)

billing_room = BillingRoom.create(
      user_id: user.id,
      name: 'NewRoom',
      users: [{id: user.id}],
      billing_records: []
    )

new_billing_record = BillingRecord.new(user_id: user.id, name: 'Coke', amount: 12.99)
