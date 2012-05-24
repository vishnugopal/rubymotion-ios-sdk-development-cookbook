class CookbookDocument < CollectableDocument
  collection_of Recipe

  def recipes
    @collection
  end
end