class Chat < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, dependent: :destroy

  enum status: { waiting: 0, active: 1, end: 2 }
end
