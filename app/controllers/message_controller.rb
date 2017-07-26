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
      flash[:message_sent] = "message sent!"
      redirect "/messages"
    end
  end

  #          -----New Message-----
  get '/messages/new' do
    redirect_if_not_logged_in

    @user = current_user
    erb :'/messages/create_message'
  end

  #          -----Reply-----
  get '/messages/:id/reply' do
    redirect_if_not_logged_in

    @user = current_user
    @recipient = User.find(params[:id])
    erb :'/messages/create_message'
  end

  #          -----Show Message-----
  get '/messages/:id' do
    redirect_if_not_logged_in

    @message = Message.find(params[:id])
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
