require_relative './SpriteSheet.rb'

class Assets
  attr_accessor :player, :stone, :grass, :tiles, :spritesheet
  @@tiles
  class << self
    def grass
      return @grass
    end
    def stone
      return @stone
    end
    def tiles(x, y)
       @@tiles[x][y]
    end
  end

  def initialize
    @@tiles = Array.new(40){Array.new(40)}
    @w = @h = 32
    @spritesheet = SpriteSheet.new
    @player = @spritesheet.playerCrop 0, 0, @w, @h
    @stone = @spritesheet.tileCrop 0, @h * 14, @w, @h
    @grass = @spritesheet.tileCrop @w * 1, @h * 1, @w, @h
    @plant = @spritesheet.tileCrop 0, @h * 11, @w, @h
    setTiles
  end

  def setTiles
    @@tiles[0][0] = @grass
    @@tiles[0][14] = @stone
    @@tiles[0][11] = @plant
  end

end
