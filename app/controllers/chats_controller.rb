class ChatsController < ApplicationController
  def show
    @chat = Chat.where(users_count: 1, status: :waiting).first

    if @chat.nil?
      @chat = Chat.create(users_count: 1)
    else
      @chat.update(users_count: 2, status: :active)
    end

    @user = User.create(chat_id: @chat.id)
  end
end
