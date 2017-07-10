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
    when "Friend Request"
      redirect "/friends/#{friend.id}"
    when "Share Recipe"
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


  end

end
