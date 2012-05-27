class CookbookDocument < PeerDocument
  CHANGED = "PRPRecipesDidChangeNotification"

  collection_of Recipe

  def recipes
    @collection
  end

  def addRecipesFromCookbook(cookbook)
    self.recipes.addObjectsFromArray(cookbook.recipes)
    NSLog("Objects added")
    NSNotificationCenter.defaultCenter.postNotificationName(CookbookDocument::CHANGED, object: self)
    NSLog("Notification set")
    save
  end
end