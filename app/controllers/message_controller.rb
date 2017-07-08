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

    owner = User.find(params[:owner_id])
    message = owner.messages.create(params)
    redirect "/messages"
  end

  #          -----Show Messages-----
  get '/messages/:id' do
    redirect_if_not_logged_in

    @user = current_user
    @message = Message.find(params[:id])
    @recipe = @message.recipe
    erb :'/messages/show_message'
  end

end
