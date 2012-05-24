module Collectable
  module ClassMethods
    attr_reader :collection_class

    def collection_of(klass)
      @collection_class = klass
    end
  end

  module InstanceMethods
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

    def deleteAtIndex(index)
      collection.removeObjectAtIndex(index)
    end

    def create
      self.class.collection_class.new.tap do |item|
        collection << item 
      end
    end

    def indexOf(item)
      collection.indexOfObject(item)
    end
  end
end