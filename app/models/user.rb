# frozen_string_literal: true

require 'bcrypt'
class User
  include Dynamoid::Document

  table name: :users, key: :user_uuid, capacity_mode: :on_demand

  field :username
  field :email

  field :encrypted_password

  global_secondary_index hash_key: :username, projected_attributes: :all

  # Use virtual attribute to store the plain text password temporarily
  attr_accessor :password

  validates :email, presence: true
  validates :password, presence: true, on: :create

  before_save :encrypt_password


  def jwt_subject
    user_uuid
  end

  def encrypt_password
    return if password.blank?

    self.encrypted_password = BCrypt::Password.create(password)
    self.password = nil # Clear the plain text password after encryption
  end

  def authenticate(plain_text_password)
    BCrypt::Password.new(encrypted_password) == plain_text_password
  end

  def to_h
    attributes.except(:encrypted_password)
  end

  def to_json(*_args)
    to_h.to_json
  end
end
