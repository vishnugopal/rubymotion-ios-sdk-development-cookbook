class PeerDocument < UIDocument
  class << self
    attr_reader :collection_class

    def collection_of(klass, options = {})
      @collection_class = klass
    end
  end

  attr_reader :collection

  def collection
    @collection ||= []
  end

  def count
    collection.count
  end

  def [](index)
    collection[index]
  end

  def []=(index, item)
    collection[index] = item if item.is_a? self.class.collection_class
  end

  def indexOf(item)
    collection.indexOfObject(item)
  end

  def create
    self.class.collection_class.new.tap do |item|
      collection << item 
      save
    end
  end

  def deleteAtIndex(index)
    collection.removeObjectAtIndex(index)

    save
  end

  def save
    self.updateChangeCount(UIDocumentChangeDone)
  end

  def contentsForType(typeName, error: error)
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

  def data(error = nil)
    error = Pointer.new(object) unless error
    data = nil

    coordinator = NSFileCoordinator.alloc.initWithFilePresenter(nil)
    coordinator.coordinateReadingItemAtURL(self.fileURL, 
      options: NSFileCoordinatorReadingWithoutChanges, 
      error: error,
      byAccessor: lambda { |url|
        data = NSData.dataWithContentsOfURL(url)
      })

    return data
  end

  def handleError(error, userInteractionPermitted: userInteractionPermitted)
    if(error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError)
      self.saveToURL(self.fileURL, forSaveOperation: UIDocumentSaveForCreating, completionHandler: lambda { |success|
        if(success)
          NSLog("Created a new document for: #{self.class}.")
        else
          NSLog("Tried to create a new document for: #{self.class}, but failed.")
        end
      })
    else
      super
    end
  end
end