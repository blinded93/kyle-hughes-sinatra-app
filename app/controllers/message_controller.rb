class MessageController < ApplicationController

  get '/messages' do
    redirect_if_not_logged_in


  end

  post '/messages' do
    binding.pry
    redirect_if_not_logged_in

    @content = ""
    @user = current_user
    @friend = params[:friend]
    # @message = @friend.messages.build(owner_id: @friend.id, sender_id: @user.id)
  end

end
