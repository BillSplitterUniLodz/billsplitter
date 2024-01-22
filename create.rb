# frozen_string_literal: true

user = User.create(
  username: 'admin1',
  password: 'password',
  email: 'admin@admin.com'
)

user1 = User.create(
  username: 'admin',
  password: 'password',
  email: 'admin1@admin.com'
)

user2 = User.create(
  username: 'admin',
  password: 'password',
  email: 'admin1@admin.com'
)

# Create initial group
group = Group.create(
  name: 'Vienna',
  top_level: true,
  participant_uuid: user.user_uuid
)

# Add user1 to group
group_1 = Group.create(
  name: 'Lodz',
  top_level: false,
  group_uuid: group.group_uuid,
  participant_uuid: user1.user_uuid
)

group_1_1 = Group.create(
  name: 'Lodz',
  top_level: false,
  group_uuid: group.group_uuid,
  participant_uuid: user2.user_uuid
)

group_2 = Group.create(
  name: 'Lodz',
  top_level: true,
  participant_uuid: user.user_uuid
)

expense_negative = Expense.create(
  group_uuid: group.group_uuid,
  user_uuid: group.participant_uuid,
  payer_uuids: group.participant_uuids,
  name: 'Hotel',
  amount: -90000
)

positive = Expense.create(
  group_uuid: group.group_uuid,
  user_uuid: group_1.participant_uuid,
  payer_uuids: [group.participant_uuid],
  name: 'Hotel',
  amount: 30000
)

positive = Expense.create(
  group_uuid: group.group_uuid,
  user_uuid: group_1_1.participant_uuid,
  payer_uuids: [group.participant_uuid],
  name: 'Hotel',
  amount: 30000
)

Expenses::ExpensesBreakdown.new(group).calculate
