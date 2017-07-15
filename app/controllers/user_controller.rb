class UserController < ApplicationController

  #           -----List Friends-----
  get  '/friends' do
    redirect_if_not_logged_in

    @user = current_user
    erb :'/users/friends'
  end

  #          -----Find Friends-----
  get '/friends/find' do
    redirect_if_not_logged_in

    @user = current_user
    @users = User.all
    erb :'/users/friend_find'
  end

  post '/friends' do
    redirect_if_not_logged_in

    if params[:query].include?("@")
      friend = User.find_by(email: params[:query])
    else
      friend = User.find_by(username: params[:query])
    end

    if !friend.nil?
      redirect "/friends/#{friend.id}"
    else
      flash[:nonexistant] = "i could not find what you were looking for."
      redirect "/friends/find"
    end
  end

  #          -----Confirm Friend-----
  patch '/friends/:id/confirm' do
    redirect_if_not_logged_in

    user = current_user
    friend = User.find(params[:sender_id])
    user.add_friend(friend)
    Message.find(params[:message_id]).destroy
    redirect "/friends"
  end

  #          -----Delete Friend-----
  delete '/friends/:id/delete' do
    redirect_if_not_logged_in

    user = current_user
    friend = User.find(params[:id])
    user.remove_friend(friend)
    redirect "/friends"
  end

  #          -----Show Friend-----
  get '/friends/:id' do
    redirect_if_not_logged_in

    @user = current_user
    @friend = User.find(params[:id])
    erb :'/users/friend_show'
  end


  #           -----Sign Up-----
  get '/signup' do
    redirect "/recipes" if logged_in?

    erb :'/users/create_user'
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect "/recipes"
    else
      flash[:signup] = "there seems to have been a problem creating your account. please try again."

      redirect "/signup"
    end
  end

  #           -----Log In-----
  get '/login' do
    redirect '/recipes' if logged_in?
    erb :'/users/login'
  end

  post '/login' do
    if params[:user].include?("@")
      user = User.find_by(email: params[:user])
    else
      user = User.find_by(username: params[:user])
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/recipes"
    else
      flash[:login] = "There was a problem logging in, please try again."

      redirect "/login"
    end
  end

  #      -----Log Out-----
  get '/logout' do
    session.clear
    flash[:logout] = "you have been logged out."
    
    redirect "/"
  end

end
