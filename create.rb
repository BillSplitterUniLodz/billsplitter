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

# Create initial group
group = Group.create(
  name: 'Vienna',
  participant_uuid: user.user_uuid
)

# Add user1 to group
group1 = Group.create(
  name: 'Vienna',
  group_uuid: group.group_uuid,
  participant_uuid: user1.user_uuid
)

# Add to group
# group = Group.find(uuid: group_uuid)
# new_group = group.clone
# new_group.participant_uuid = params[:new_user]

expense = Expense.create(

)
