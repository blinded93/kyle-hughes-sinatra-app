class MessageController < ApplicationController

  #          -----Show Messages-----
  get '/messages' do
    redirect_if_not_logged_in


  end

  #          -----Send Message-----
  post '/messages' do
    binding.pry
    redirect_if_not_logged_in

    @content = ""
    @user = current_user
    @friend = params[:owner_id]
    # @message = @friend.messages.build(owner_id: @friend.id, sender_id: @user.id)
  end

end
