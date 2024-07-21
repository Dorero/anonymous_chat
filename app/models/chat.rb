class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users

  enum status: { waiting: 0, active: 1 }
end
