class RecipesListController < UITableViewController
  attr_accessor :dataSource

  def viewDidLoad
    @recipesEdit = self.navigationItem.leftBarButtonItem
    @recipesEdit.target = self
    @recipesEdit.action = "editOrDone:"
  end

  def editOrDone(sender)
    if self.tableView.editing? #button clicked when editing, so let's show edit and stop editing
      sender.title = "Edit"
      sender.style = UIBarButtonItemStyleBordered
      self.tableView.setEditing(false, animated: true)
    else
      sender.title = "Done" #button clicked when not editing, so let's edit & show done
      sender.style = UIBarButtonItemStyleDone
      self.tableView.setEditing(true, animated: true)
    end
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

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    if tableView.editing?
      self.performSegueWithIdentifier("editRecipe", sender:tableView.cellForRowAtIndexPath(indexPath))
    else
      self.performSegueWithIdentifier("presentRecipeDetail", sender:tableView.cellForRowAtIndexPath(indexPath))
    end
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
      editController.recipeListController = self
      editController.editingMode = :create
    when "editRecipe"
      index = self.tableView.indexPathForCell(sender)
      editController = segue.destinationViewController.topViewController

      editController.recipe = self.dataSource[index.row]
      editController.recipeListController = self
      editController.editingMode = :update
    end
  end
end