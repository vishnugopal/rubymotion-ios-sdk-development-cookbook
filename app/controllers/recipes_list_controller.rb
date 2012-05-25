class RecipesListController < UITableViewController
  attr_accessor :dataSource

  def viewDidLoad
    @recipesEdit = self.navigationItem.leftBarButtonItem
    @recipesEdit.target = self
    @recipesEdit.action = "sendEmail:"
  end

  def sendEmail(sender)
    mailViewController = MFMailComposeViewController.alloc.init
    mailViewController.delegate = self
    mailViewController.subject = "Great Recipes"

    error = Pointer.new(:object)
    mailViewController.addAttachmentData(self.dataSource.data(error), 
      mimeType: "application/octet-stream",
      fileName: "Recipes.recipes")

    unless error[0]
      mailViewController.mailComposeDelegate = self
      self.presentModalViewController(mailViewController, animated: true)
    else
      NSLog("Error in coordinating read: %@", error[0])
    end
  end

  def mailComposeController(controller, didFinishWithResult:result, error: error)
    controller.dismissModalViewControllerAnimated(true)
  end

  def finishedEditingRecipe(recipe, editingMode)
    row = self.dataSource.indexOf(recipe)
    path = NSIndexPath.indexPathForRow(row, inSection:0)
    
    case editingMode
    when :create
      self.tableView.insertRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationLeft)
    when :update
      self.tableView.reloadRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationAutomatic)
    end

    self.dataSource.save
  end

  def canceledEditingRecipe(recipe, recipePristineCopy, editingMode)
    row = self.dataSource.indexOf(recipe)
    path = NSIndexPath.indexPathForRow(row, inSection:0)

    case editingMode
    when :create
      self.dataSource.deleteAtIndex(row)
    when :update
      self.dataSource[row] = recipePristineCopy
      self.tableView.reloadRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationAutomatic)
    end
  end

  def recipesChanged(recipe, editingMode)
    row = self.dataSource.indexOf(recipe)
    path = NSIndexPath.indexPathForRow(row, inSection:0)

    case editingMode
    when :update
      self.tableView.reloadRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationAutomatic)
    end

    self.dataSource.save
  end

  def numberOfSectionsInTableView(tableView) 
    1
  end

  def tableView(tableView, numberOfRowsInSection: section) 
    dataSource.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    cellIdentifier = "Cell"
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)

    cell.textLabel.text = self.dataSource[indexPath.row].title
    cell.imageView.image = self.dataSource[indexPath.row].image
    cell.detailTextLabel.text = "#{self.dataSource[indexPath.row].preparationTime} minutes"

    cell
  end

  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)
    if(editingStyle == UITableViewCellEditingStyleDelete)
      self.dataSource.deleteAtIndex(indexPath.row)
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation:UITableViewRowAnimationFade)
    elsif(editingStyle == UITableViewCellEditingStyleInsert)
    end
  end

  def tableView(tableView, accessoryButtonTappedForRowWithIndexPath: indexPath)
    cell = tableView.cellForRowAtIndexPath(indexPath)
    self.performSegueWithIdentifier("editRecipe", sender: cell)
  end

  def prepareForSegue(segue, sender:sender)
    case segue.identifier 
    when "presentRecipeDetail"
      index = self.tableView.indexPathForCell(sender)
      segue.destinationViewController.setRecipe(self.dataSource[index.row])
    when "addRecipe"
      recipe = self.dataSource.create
      editController = segue.destinationViewController.topViewController
      
      editController.recipe = recipe
      editController.recipeEditorControllerDelegate = self
      editController.editingMode = :create
    when "editRecipe"
      index = self.tableView.indexPathForCell(sender)
      editController = segue.destinationViewController.topViewController

      editController.recipe = self.dataSource[index.row]
      editController.recipeEditorControllerDelegate = self
      editController.editingMode = :update
    end
  end
end