class User < ApplicationRecord
  belongs_to :chat, optional: true
  has_many :messages
end
