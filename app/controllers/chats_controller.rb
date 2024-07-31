class ChatsController < ApplicationController
  def show
    p params[:id]
    p params[:user_id]
    @chat_id = params[:id]
    @user_id = params[:user_id]
  end

  def index

  end


  def search
    gender = case params[:gender]
             when 0
               :female
             when 1
               :male
             else
               :no_matter
             end
    search_age = params[:partner_age].split(" ")
    chat = Chat.joins(:users).where(users_count: 1, status: :waiting, users: user_search_conditions(search_age.first, search_age.last)).first

    if chat.nil?
      chat = Chat.create(users_count: 1)
    else
      chat.update(users_count: 2, status: :active)
    end

    user = User.create(age: params[:age], gender: gender, chat_id: chat.id)

    redirect_to chat_path(id: chat.id, user_id: user.id)
  end

  private

  def user_search_conditions(search_age_from, search_age_to)
    conditions = { age: search_age_from..search_age_to }

    conditions[:gender] = params[:partner_gender] if params[:partner_gender] != 2

    conditions
  end
end
