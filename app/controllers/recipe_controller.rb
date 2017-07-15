class RecipeController < ApplicationController
  #          -----User Recipe Homepage-----
  get '/recipes' do
    redirect_if_not_logged_in

    @user = current_user
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
    if recipe.save
      flash[:new] = "Successully saved!"
      redirect "/recipes"
    else
      flash[:new] = "There was a problem saving your recipe. Please try again."

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
    new_recipe = current_user.recipes.create(attrs)
    Message.find(params[:message_id]).destroy if !params[:message_id].nil?

    redirect "/recipes/#{new_recipe.id}"
  end

  #          -----Edit Recipe-----
  get '/recipes/:id/edit' do
    redirect_if_not_logged_in

    @user = current_user
    @recipe = Recipe.find(params[:id])
    if @user && owned?
      erb :'/recipes/edit_recipe'
    else
      flash[:not_owner] = "You do not own this."
      redirect "/recipes/#{params[:id]}"
    end
  end

  patch '/recipes/:id' do
    redirect_if_not_logged_in

    user = current_user
    recipe = Recipe.find(params[:id])
    if user.id == recipe.user.id
      recipe = Recipe.find(params[:id])
      recipe.update(params[:recipe])
      flash[:edit] = "Successfully saved!"

      redirect "/recipes/#{params[:id]}"
    else
      flash[:owner] = "You do not own this."

      redirect "/recipes/#{params[:id]}"
    end
  end

  patch '/recipes/:id/favorite' do
    redirect_if_not_logged_in

    @recipe = Recipe.find(params[:id])
    if owned? && @recipe.favorite == 0
      @recipe.favorite = 1
      if @recipe.save
        redirect "/recipes/#{@recipe.id}"
      else
        flash[:problem] = "There seems to have been a problem."
      end
    elsif owned? && @recipe.favorite == 1
      @recipe.favorite = 0
      if @recipe.save
        redirect "/recipes/#{@recipe.id}"
      else
        fash[:problem] = "There seems to have been a problem."
      end
    else
      flash[:owner] = "You do not own this."
      redirect "/recipes/#{@recipe.id}"
    end
  end

  #          -----Delete Recipe-----
  delete '/recipes/:id/delete' do
    redirect_if_not_logged_in

    @recipe = Recipe.find(params[:id])
    if owned?
      @recipe.destroy
      flash[:delete] = "Recipe deleted."
      redirect "/recipes"
    else
      flash[:owner] = "You do not own this."
      redirect "/recipes/#{recipe.id}"
    end
  end

end
