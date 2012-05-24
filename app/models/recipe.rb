class Recipe
  attr_accessor :title
  attr_accessor :directions
  attr_accessor :image
  attr_accessor :preparationTime

  def initialize
    @title = "New Recipe"
    @directions = @image = @preparationTime = nil
  end

  def encodeWithCoder(coder)
    [:title, :directions, :image, :preparationTime].each do |attribute|
      value = instance_variable_get("@#{attribute}".to_sym)
      coder.encodeObject(value, forKey: attribute.to_s)
    end
  end

  def initWithCoder(coder)
    [:title, :directions, :image, :preparationTime].each do |attribute|
      instance_variable_set("@#{attribute}".to_sym, coder.decodeObjectForKey(attribute.to_s))
    end

    self
  end
end