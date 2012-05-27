class Recipe < PeerModel
  property :title
  property :directions
  property :image
  property :preparationTime

  def initialize
    self.title = "New Recipe"
    self.directions = self.image = self.preparationTime = nil
  end
end