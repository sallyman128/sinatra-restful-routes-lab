class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes/new' do #render form to create new recipe
    erb :new
  end

  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes/:id' do #display single recipe
    @recipe = Recipe.find(params[:id])
    erb :show
  end 

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit single recipe and redirect to single recipe show
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes' do #displays all recipes
    @recipes = Recipe.all
    erb :index  
  end

  delete '/recipes/:id' do #delete recipe from database and redirect to index
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect to '/articles'
  end
end
