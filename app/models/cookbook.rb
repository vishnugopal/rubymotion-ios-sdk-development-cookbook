class Cookbook
  attr_accessor :recipes

  def initialize
    seedData
  end

  def count
    @recipes.count
  end

  def [](index)
    @recipes[index]
  end

  def []=(index, recipe)
    @recipes[index] = recipe if recipe.is_a? Recipe
  end

  def deleteAtIndex(index)
    @recipes.removeObjectAtIndex(index)
  end

  def addAndReturnRecipe
    Recipe.new.tap do |recipe|
      @recipes << recipe 
    end
  end

  def indexOfRecipe(recipe)
    self.recipes.indexOfObject(recipe)
  end

  def seedData
    recipes = []
    recipe = Recipe.new
    recipe.title = "1 - Chocolate Chip Cookies"
    recipe.directions = "Put the flour and other dry ingredients in a bowl, " +
    "stir in the eggs until evenly moist. Add chocolate chips and stir until even. " +
    "Place tablespoon sized portions on greased cookie sheet and bake at 350° for " +
    "6 minutes"
    recipe.image = UIImage.imageNamed "chocolate-cookie.jpg"
    recipe.preparationTime = 33
    recipes << recipe

    recipe = Recipe.new
    recipe.title = "2 - Chocolate Chip Cookies"
    recipe.directions = "Put the flour and other dry ingredients in a bowl, " +
    "stir in the eggs until evenly moist. Add chocolate chips and stir until even. " +
    "Place tablespoon sized portions on greased cookie sheet and bake at 350° for " +
    "6 minutes"
    recipe.image = UIImage.imageNamed "chocolate-cookie.jpg"
    recipe.preparationTime = 33
    recipes << recipe

    recipe = Recipe.new
    recipe.title = "3 - Chocolate Chip Cookies"
    recipe.directions = "Put the flour and other dry ingredients in a bowl, " +
    "stir in the eggs until evenly moist. Add chocolate chips and stir until even. " +
    "Place tablespoon sized portions on greased cookie sheet and bake at 350° for " +
    "6 minutes"
    recipe.image = UIImage.imageNamed "chocolate-cookie.jpg"
    recipe.preparationTime = 33
    recipes << recipe

    recipe = Recipe.new
    recipe.title = "4 - Chocolate Chip Cookies"
    recipe.directions = "Put the flour and other dry ingredients in a bowl, " +
    "stir in the eggs until evenly moist. Add chocolate chips and stir until even. " +
    "Place tablespoon sized portions on greased cookie sheet and bake at 350° for " +
    "6 minutes"
    recipe.image = UIImage.imageNamed "chocolate-cookie.jpg"
    recipe.preparationTime = 33
    recipes << recipe

    recipe = Recipe.new
    recipe.title = "5 - Chocolate Chip Cookies"
    recipe.directions = "Put the flour and other dry ingredients in a bowl, " +
    "stir in the eggs until evenly moist. Add chocolate chips and stir until even. " +
    "Place tablespoon sized portions on greased cookie sheet and bake at 350° for " +
    "6 minutes"
    recipe.image = UIImage.imageNamed "chocolate-cookie.jpg"
    recipe.preparationTime = 33
    recipes << recipe

    @recipes = recipes
  end
end