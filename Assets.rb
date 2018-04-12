require_relative './SpriteSheet.rb'

class Assets
  attr_accessor :player, :player_down, :player_up, :player_x, :stone, :grass, :tiles, :spritesheet
  @@tiles
  class << self
    def grass
      return @grass
    end
    def stone
      return @stone
    end
    def tiles(x)
       return @@tiles[x]
    end
  end

  def initialize
    @@tiles = Array.new(40){Array.new(40)}
    @w = @h = 32
    @spritesheet = SpriteSheet.new
    @player_down = []
    @player_up = []
    @player_x = []
    @player
    @player = @spritesheet.playerCrop @w, 32 * 2 + 8, @w, @h + 3

    @player_down[0] = @spritesheet.playerCrop 0, 32 * 2 + 8, @w, @h + 3
    @player_down[1] = @spritesheet.playerCrop @w, 32 * 2 + 8, @w, @h + 3
    @player_down[2] = @spritesheet.playerCrop @w * 2, 32 * 2 + 8, @w, @h + 3
    @player_down[3] = @spritesheet.playerCrop @w, 32 * 2 + 8, @w, @h + 3

    @player_up[0] = @spritesheet.playerCrop 0, 0, @w, @h
    @player_up[1] = @spritesheet.playerCrop @w, 0, @w, @h
    @player_up[2] = @spritesheet.playerCrop @w * 2, 0, @w, @h
    @player_up[3] = @spritesheet.playerCrop @w, 0, @w, @h

    @player_x[0] = @spritesheet.playerCrop 0, 32 * 3 + 12, @w, @h
    @player_x[1] = @spritesheet.playerCrop @w, 32 * 3 + 12, @w, @h
    @player_x[2] = @spritesheet.playerCrop @w * 2, 32 * 3 + 12, @w, @h
    @player_x[3] = @spritesheet.playerCrop @w, 32 * 3 + 12, @w, @h

    @stone = @spritesheet.tileCrop 0, @h * 14, @w, @h
    @grass = @spritesheet.tileCrop @w * 1, @h * 1, @w, @h
    @plant = @spritesheet.tileCrop 0, @h * 11, @w, @h
    setTiles
  end

  def setTiles
    @@tiles[0] = @grass
    @@tiles[1] = @stone
    @@tiles[2] = @plant
  end

end
