class Cookbook
  extend Collectable::ClassMethods
  include Collectable::InstanceMethods

  collection_of Recipe

  def initialize
    seedData
  end

  def recipes
    @collection
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

    self.collection = recipes
  end
end