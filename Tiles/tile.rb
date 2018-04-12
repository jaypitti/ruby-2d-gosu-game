class Tile

  @@Tiles = []
  @@GrassTile = Grass.new(0)

  class << self
    def tiles(id)
      return @@Tiles[id]
    end
  end
  def initialize asset, id
    @@Tiles[id] = self;
  end

  def update
  end

  def draw
  end
end

class Grass < Tile
  def initialize id
    super
    Tile.new Assets.grass, id
  end

  def isSolid
    return false
  end
end
