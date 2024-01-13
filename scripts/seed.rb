#!/usr/bin/env ruby

User.create(
  user_uuid: SecureRandom.uuid,
  username: 'admin',
  email: 'admin@admin.com',
  password: 'password'
)
