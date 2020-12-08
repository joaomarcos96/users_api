# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  include Discard::Model

  validates :first_name, :last_name, :email, presence: true

  def active_for_authentication?
    super && !discarded?
  end

  def admin?
    role == 'admin'
  end
end
