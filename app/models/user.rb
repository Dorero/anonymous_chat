class User < ApplicationRecord
  belongs_to :chat, optional: true
  has_many :messages

  enum gender: { female: 0, male: 1, no_matter: 2 }
end
