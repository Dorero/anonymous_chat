class ChatChannel < ApplicationCable::Channel
  def subscribed
    @chat = Chat.find(params[:chat_id])
    @user = User.find(params[:user_id])
    stream_from "chat_#{@chat.id}_channel"
  end

  def unsubscribed
    @user.destroy
    @chat.update(status: :end, users_count: @chat.users_count - 1)
    ActionCable.server.broadcast "chat_#{@chat.id}_channel", {status: @chat.status}

    if @chat.users_count < 1
      @chat.destroy
    end
  end

  def speak(data)
    @chat.messages.create!(content: data['message'], user_id: data['user_id'])
    ActionCable.server.broadcast "chat_#{@chat.id}_channel", {content: data["message"], user_id: data['user_id'], status: @chat.status}
  end
end
