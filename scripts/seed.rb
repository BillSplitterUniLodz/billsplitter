#!/usr/bin/env ruby
# frozen_string_literal: true

User.create(
  user_uuid: SecureRandom.uuid,
  username: 'admin',
  email: 'admin@admin.com',
  password: 'password'
)
