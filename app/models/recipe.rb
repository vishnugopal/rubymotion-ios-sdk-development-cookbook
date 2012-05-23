class Recipe

  attr_accessor :title
  attr_accessor :directions
  attr_accessor :image
  attr_accessor :preparationTime

  def initialize
    @title = "New Recipe"
    @directions = @image = @preparationTime = nil
  end

end