class RecipeEditorController < UIViewController
  attr_accessor :recipe, :recipeEditorControllerDelegate, :editingMode

  def viewDidLoad
    @recipeCancel = self.navigationItem.leftBarButtonItem
    @recipeDone = self.navigationItem.rightBarButtonItem
    @recipeTitle = view.viewWithTag 2
    @recipeDirections = view.viewWithTag 3
    @recipePreparationTime = view.viewWithTag 4
    @recipePreparationTimeStepper = view.viewWithTag 5
    @recipeImage = view.viewWithTag 6

    @recipeCancel.target = self
    @recipeCancel.action = "cancel:"

    @recipeDone.target = self
    @recipeDone.action = "done:"
    
    @recipePreparationTimeStepper.addTarget self, action:'changePreparationTime:', forControlEvents:UIControlEventTouchUpInside

    @recipeTitle.delegate = self
  end

  def viewWillAppear(animated)
    super

    @recipeTitle.text = self.recipe.title
    @recipeDirections.text  = 
      (self.recipe.directions && !self.recipe.directions.empty?) ? self.recipe.directions : "Tap to edit directions"
    @recipeImage.image = self.recipe.image if self.recipe.image
    @recipePreparationTime.text = "#{self.recipe.preparationTime.to_i} min"
    @recipePreparationTimeStepper.value = self.recipe.preparationTime.to_f
  end

  def prepareForSegue(segue, sender: sender)
    case segue.identifier
    when "editDirections"
      segue.destinationViewController.recipe = self.recipe
    when "choosePhoto"
      segue.destinationViewController.delegate = self
    end
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
  end

  def textFieldDidEndEditing(textField)
    self.recipe.title = textField.text
    self.recipeEditorControllerDelegate.recipesChanged(self.recipe, editingMode)
  end

  def recipe=(recipe)
    @recipe = recipe
    @recipePristineCopy = recipe.dup
  end

  def cancel(sender)
    self.dismissModalViewControllerAnimated(true)
    self.recipeEditorControllerDelegate.canceledEditingRecipe(self.recipe, @recipePristineCopy, editingMode)
  end

  def done(sender)
    self.dismissModalViewControllerAnimated(true)
    self.recipeEditorControllerDelegate.finishedEditingRecipe(self.recipe, editingMode)
  end

  def changePreparationTime(sender)
    self.recipe.preparationTime = sender.value.to_i
    @recipePreparationTime.text = "#{sender.value.to_i} min"
    self.recipeEditorControllerDelegate.recipesChanged(self.recipe, editingMode)
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo:info)
    self.recipe.image = info[UIImagePickerControllerOriginalImage]
    picker.dismissModalViewControllerAnimated(true)
    self.recipeEditorControllerDelegate.recipesChanged(self.recipe, editingMode)
  end

  def imagePickerControllerDidCancel(picker)
    picker.dismissModalViewControllerAnimated(true)
  end

  def viewDidUnload
    @recipeTitle = @recipeDescription = @recipePreparationTime = @recipePreparationTimeStepper = @recipeImage = nil
  end
end