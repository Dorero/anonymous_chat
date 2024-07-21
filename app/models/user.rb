class User < ApplicationRecord
  belongs_to :chat
  has_many :messages
end
