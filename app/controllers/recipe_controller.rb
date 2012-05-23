class RecipeController < UIViewController
  attr_accessor :recipe

  def viewDidLoad
    @recipeDirections = view.viewWithTag 1
    @recipePreparationTime = view.viewWithTag 2
    @recipeImage = view.viewWithTag 3
  end

  def viewWillAppear(animated)
    super

    self.title = self.recipe.title
    @recipeDirections.text = self.recipe.directions
    @recipePreparationTime.text = "#{self.recipe.preparationTime} minutes"
    @recipeImage.image = self.recipe.image if self.recipe.image
  end

  def viewDidUnload
    @recipeTitle = @recipeDirections = @recipeImage = nil
  end
end