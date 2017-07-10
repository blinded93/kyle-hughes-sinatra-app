require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "session_password"
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do

    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_not_logged_in
      redirect "/login" if !logged_in?
    end

    def owned?
      current_user.id == @recipe.user.id
    end

    def friends?
      !!@user.friends.include?(@friend)
    end

    def owned_recipe?(recipe)
      user_recipe_names = current_user.recipes.collect{|recipe| recipe.name}

      user_recipe_names.include?(recipe.name)
    end
  end

end
