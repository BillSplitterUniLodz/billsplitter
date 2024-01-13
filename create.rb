# frozen_string_literal: true

user = User.create(
  username: 'admin',
  password: 'password',
  email: 'admin@admin.com'
)

Group.create(
  name: 'Vienna',
  participant_uuid: user.user_uuid
)

Expense.create
