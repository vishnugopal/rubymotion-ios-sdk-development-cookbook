class RecipesListController < UITableViewController
  attr_accessor :dataSource

  def finishedEditingRecipe(recipe)
    row = self.dataSource.indexOfRecipe(recipe)
    path = NSIndexPath.indexPathForRow(row, inSection:0)
    self.tableView.insertRowsAtIndexPaths([path], withRowAnimation:UITableViewRowAnimationLeft)
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

  def prepareForSegue(segue, sender:sender)
    case segue.identifier 
    when "presentRecipeDetail"
      index = self.tableView.indexPathForCell(sender)
      segue.destinationViewController.setRecipe(self.dataSource[index.row])
    when "addNewRecipe"
      recipe = self.dataSource.addAndReturnRecipe
      editController = segue.destinationViewController.topViewController
      
      editController.recipe = recipe
      editController.recipeListController = self
    end
  end
end