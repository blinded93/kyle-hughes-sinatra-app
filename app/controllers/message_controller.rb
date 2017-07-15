class MessageController < ApplicationController

  #          -----Messages-----
  get '/messages' do
    redirect_if_not_logged_in

    @user = current_user
    @messages = @user.messages.reverse
    erb :'/messages/inbox'
  end

  #          -----Send Message-----
  post '/messages' do
    redirect_if_not_logged_in

    friend = User.find(params[:message][:sender_id])
    owner = User.find(params[:message][:user_id])
    message = owner.messages.create(params[:message])

    case params[:message][:content]
    when "friend request"
      flash[:request_sent] = "friend request sent!"
      redirect "/friends/#{owner.id}"
    when "share recipe"
      flash[:recipe_shared] = "recipe shared!"
      redirect "/recipes/#{message.recipe_id}"
    else
      redirect "/messages"
    end
  end

  #          -----Show Messages-----
  get '/messages/:id' do
    redirect_if_not_logged_in

    @user = current_user
    @message = Message.find(params[:id])
    @recipe = @message.recipe
    erb :'/messages/show_message'
  end

  #          -----Delete Messages-----
  delete '/messages/delete' do
    redirect_if_not_logged_in

    params[:message_ids].each {|id| Message.find(id).destroy}
    flash[:deleted] = "message(s) deleted"

    redirect "/messages"
  end

end
