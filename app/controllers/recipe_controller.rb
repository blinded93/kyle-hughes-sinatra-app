class RecipeController < ApplicationController
  #          -----User Recipe Homepage-----
  get '/recipes' do
    redirect_if_not_logged_in

    @user = current_user
    @recipes = @user.recipes.sort_by{|recipe| recipe.name}
    erb :'/recipes/recipes'
  end

  #          -----Create Recipe-----
  get '/recipes/new' do
    redirect_if_not_logged_in

    erb :'/recipes/create_recipe'
  end

  post '/recipes' do
    redirect_if_not_logged_in

    recipe = current_user.recipes.build(params)
    recipe.favorite == 0
    if recipe.save
      flash[:new] = "successully saved!"

      redirect "/recipes"
    else
      flash[:new] = "there was a problem saving your recipe. please try again."

      redirect "/recipes/new"
    end
  end

  #          -----Show Recipe-----
  get '/recipes/:id' do
    redirect_if_not_logged_in

    @recipe = Recipe.find(params[:id])
    erb :'/recipes/show_recipe'
  end

  #          -----Share Recipe-----
  get '/recipes/:id/share' do
    redirect_if_not_logged_in

    @user = current_user
    @recipe = Recipe.find(params[:id])
    erb :'/recipes/share_recipe'
  end

  #          -----Save Recipe-----
  patch '/recipes/:id/save' do
    redirect_if_not_logged_in

    recipe = Recipe.find(params[:id]).dup
    attrs = recipe.attributes.to_options
    new_recipe = current_user.recipes.build(attrs)
    new_recipe.favorite = 0
    new_recipe.save

    Message.find(params[:message_id]).destroy if !params[:message_id].nil?
    flash[:save] = "recipe saved!"

    redirect "/recipes/#{new_recipe.id}"
  end

  #          -----Edit Recipe-----
  get '/recipes/:id/edit' do
    redirect_if_not_logged_in

    @user = current_user
    @recipe = Recipe.find(params[:id])

    if owned?
      erb :'/recipes/edit_recipe'
    else
      flash[:not_owner] = "you do not own this."

      redirect "/recipes/#{params[:id]}"
    end
  end

  patch '/recipes/:id' do
    redirect_if_not_logged_in

    @recipe = Recipe.find(params[:id])

    if owned?
      @recipe.update(params[:recipe])
      flash[:edit] = "edit saved!"

      redirect "/recipes/#{params[:id]}"
    else
      flash[:not_owner] = "you do not own this."

      redirect "/recipes/#{params[:id]}"
    end
  end

  #          -----Favorite Recipe-----
  patch '/recipes/:id/favorite' do
    redirect_if_not_logged_in

    @recipe = Recipe.find(params[:id])

    if owned? && @recipe.favorite == 0 || @recipe.favorite.nil?
      @recipe.favorite = 1
      @recipe.save
    elsif owned? && @recipe.favorite == 1
      @recipe.favorite = 0
      @recipe.save
    else
      flash[:not_owner] = "you do not own this."
    end
    redirect "/recipes/#{@recipe.id}"
  end

  #          -----Delete Recipe-----
  delete '/recipes/:id/delete' do
    redirect_if_not_logged_in

    @recipe = Recipe.find(params[:id])

    if owned?
      @recipe.destroy
      flash[:delete] = "recipe deleted."

      redirect "/recipes"
    else
      flash[:not_owner] = "you do not own this."

      redirect "/recipes/#{recipe.id}"
    end
  end

end
