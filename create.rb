user = User.create(
  username: 'admin',
  password: 'password',
  email: 'admin@admin.com'
)

group = Group.create(
  name: 'Vienna',
  participant_uuid: user.user_uuid
)

expense = Expense.create(

)
