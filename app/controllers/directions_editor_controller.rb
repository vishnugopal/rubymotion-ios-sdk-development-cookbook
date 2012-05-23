class DirectionsEditorController < UIViewController
  attr_accessor :recipe

  def viewDidLoad
    @recipeDirections = view.viewWithTag 1
    @recipeDirections.delegate = self
  end

  def viewWillAppear(animated)
    super

    self.title = "Edit Directions"
    @recipeDirections.text = self.recipe.directions
    @recipeDirections.becomeFirstResponder
  end

  def viewWillDisappear(animated)
    super

    @recipeDirections.resignFirstResponder
  end

  def textViewDidEndEditing(textView)
    self.recipe.directions = @recipeDirections.text
  end
end