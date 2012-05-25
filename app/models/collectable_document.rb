class CollectableDocument < UIDocument
  extend Collectable::ClassMethods
  include Collectable::InstanceMethods

  def deleteAtIndex(index)
    super

    self.updateChangeCount(UIDocumentChangeDone)
  end

  def create
    NSLog("Creating a new item")
    self.class.collection_class.new.tap do |item|
      collection << item 
    end

    save
  end

  def contentsForType(typeName, error: error)
    NSLog("#{self.collection}")
    NSKeyedArchiver.archivedDataWithRootObject(self.collection)
  end

  def loadFromContents(contents, ofType: typeName, error: outError)
    if(contents.is_a?(NSData) && contents.length > 0)
      @collection = NSKeyedUnarchiver.unarchiveObjectWithData(contents)

      true
    else
      false
    end
  end

  def save
    self.updateChangeCount(UIDocumentChangeDone)
  end
end