require_relative './SpriteSheet.rb'
require_relative './Grass.rb'
require_relative './Rock.rb'

class SingleTile
  class << self
    def tiles(id)
      return @@Tiles[id]
    end
  end

  @@Tiles = []
  @@GrassTile = Grass.new(0)
  @@RockTile = Rock.new(1)
  @@TILE_WIDTH = @@TILE_HEIGHT = 32

  def initialize asset, id
    @asset = asset
    @id = id

    @@Tiles[id] = self;
  end

  def update
  end

  def draw graphics, x, y
    tile.draw(x, y, @w, @h)
  end

  def isSolid bool = false
    return bool
  end

end
