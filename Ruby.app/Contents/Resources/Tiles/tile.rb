class Tile

  @@Tiles = []

  class << self
    def tiles(id)
      return @@Tiles[id]
    end
  end

  def initialize asset, tile, id
    @tile = tile
    @@Tiles[id] = self;
  end

  def update
  end

  def getTile(x, y)
    return @tile
  end

  def draw
  end
end
