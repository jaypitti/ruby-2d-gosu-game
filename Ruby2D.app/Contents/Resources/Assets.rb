load './SpriteSheet.rb'

class Assets
  attr_accessor :player, :zombie, :player_down, :player_up, :player_x, :zom_up, :zom_down, :zom_x, :plant, :stone, :grass, :tiles, :spritesheet
  @@tiles
  class << self
    def grass
      return @grass
    end
    def plant
      return SpriteSheet.new.tileCrop 0, 32 * 11, 32, 32
    end
    def stone
      return SpriteSheet.new.tileCrop 32 * 3, 32, 32, 32
    end
    def player
      return SpriteSheet.new.playerCrop 32, 32 * 2 + 8, 32, 32 + 3
    end
    def zombie
      return Spritesheet.new.enemycut @w, 0, @w, @h
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
    @player = @spritesheet.playerCrop @w, 32 * 2 + 8, @w, @h + 3
    @zombie = @spritesheet.enemycut @w, @h, @w, @h

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

    @zom_up = [];
    @zom_down= [];
    @zom_x= [];

    @zom_up[0] = @spritesheet.enemycut 0, @h * 7, @w, @h
    @zom_up[1] = @spritesheet.enemycut @w, @h * 7, @w, @h
    @zom_up[2] = @spritesheet.enemycut @w * 2, @h * 7, @w, @h
    @zom_up[3] = @spritesheet.enemycut 0, @h * 7, @w, @h

    @zom_down[0] = @spritesheet.enemycut 0,   @h, @w, @h
    @zom_down[1] = @spritesheet.enemycut @w,  @h, @w, @h
    @zom_down[2] = @spritesheet.enemycut @w * 2, @h, @w, @h
    @zom_down[0] = @spritesheet.enemycut 0,   @h, @w, @h

    @zom_x[0] = @spritesheet.enemycut 0, @h * 3, @w, @h
    @zom_x[1] = @spritesheet.enemycut @w, @h * 3, @w, @h
    @zom_x[2] = @spritesheet.enemycut @w * 2, @h * 3, @w, @h
    @zom_x[3] = @spritesheet.enemycut 0, @h * 3, @w, @h

    #TILES

    @stone = @spritesheet.tileCrop @w * 3, @h, @w, @h
    @grass = @spritesheet.tileCrop @w * 1, @h * rand(1..2), @w, @h
    @water = @spritesheet.tileCrop @w * 3, @h * 21, @w, @h
    @shore_mid = @spritesheet.tileCrop @w, @h * 22, @w, @h
    @shore_mid_bottom = @spritesheet.tileCrop @w, @h * 24, @w, @h
    @shore_left_corner = @spritesheet.tileCrop 0, @h * 22, @w, @h
    @shore_left = @spritesheet.tileCrop 0, @h * 23, @w, @h
    @shore_bottom_left_corner = @spritesheet.tileCrop 0, @h * 24, @w, @h
    @shore_right_corner = @spritesheet.tileCrop @w * 2, @h * 22, @w, @h
    @shore_bottom_right_corner = @spritesheet.tileCrop @w * 2, @h * 24, @w, @h
    @shore_right = @spritesheet.tileCrop @w * 2, @h * 23, @w, @h
  
    @sandgrass_left_corner = @spritesheet.tileCrop @w * 6, @h * 22, @w, @h
    @sandgrass_right_corner = @spritesheet.tileCrop @w * 8, @h * 22, @w, @h
    @sandgrass_bottom_left_corner = @spritesheet.tileCrop @w * 6, @h * 24, @w, @h
    @sandgrass_bottom_right_corner = @spritesheet.tileCrop @w * 8, @h * 24, @w, @h

    #plants

    @cactus = @spritesheet.tileCrop 0, @h * 11, @w, @h

    #HOUSE

    @roof_left_corner = @spritesheet.tileCrop @w * 15, @h * 2, @w, @h
    @roof_left = @spritesheet.tileCrop @w * 15, @h * 3, @w, @h
    @roof_right_corner = @spritesheet.tileCrop @w * 18, @h * 2, @w, @h
    @roof_right = @spritesheet.tileCrop @w * 18, @h * 3, @w, @h
    @roof_chimney = @spritesheet.tileCrop @w * 17, @h * 2, @w, @h
    @roof_mid = @spritesheet.tileCrop @w * 17, @h * 3, @w, @h
    @roof_front = @spritesheet.tileCrop @w * 15, @h * 4, @w, @h
    @top_mid = @spritesheet.tileCrop @w * 16, @h * 4, @w, @h
    @top_mid_right = @spritesheet.tileCrop @w * 17, @h * 4, @w, @h
    @roof_front_right = @spritesheet.tileCrop @w * 18, @h * 4, @w, @h
    @wall_top_left = @spritesheet.tileCrop @w * 15, @h * 5, @w, @h
    @wall_top_mid_left = @spritesheet.tileCrop @w * 16, @h * 5, @w, @h
    @wall_top_mid_right = @spritesheet.tileCrop @w * 17, @h * 5, @w, @h
    @wall_top_right = @spritesheet.tileCrop @w * 18, @h * 5, @w, @h
    @wall = @spritesheet.tileCrop @w * 15, @h * 8, @w, @h
    @door = @spritesheet.tileCrop @w * 17, @h * 8, @w, @h





    setTiles
  end

  def setTiles
    @@tiles[0] = @grass
    @@tiles[1] = @stone
    @@tiles[2] = @cactus
    @@tiles[3] = @roof_left
    @@tiles[4] = @roof_chimney
    @@tiles[5] = @roof_mid
    @@tiles[6] = @roof_front
    @@tiles[7] = @top_mid
    @@tiles[8] = @top_mid_right
    @@tiles[9] = @roof_front_right
    @@tiles[10] = @wall_top_left
    @@tiles[11] = @wall_top_mid_left
    @@tiles[12] = @wall_top_mid_right
    @@tiles[13] = @wall_top_right
    @@tiles[14] = @wall
    @@tiles[15] = @door
    @@tiles[16] = @water
    @@tiles[17] = @shore_mid
    @@tiles[18] = @roof_right
    @@tiles[19] = @roof_right_corner
    @@tiles[20] = @roof_left_corner
    @@tiles[21] = @shore_left_corner
    @@tiles[22] = @shore_right_corner
    @@tiles[23] = @shore_bottom_left_corner
    @@tiles[24] = @shore_left
    @@tiles[25] = @shore_bottom_right_corner
    @@tiles[26] = @shore_mid_bottom
    @@tiles[27] = @shore_right
    @@tiles[28] = @sandgrass_left_corner
    @@tiles[29] = @sandgrass_right_corner
    @@tiles[30] = @sandgrass_bottom_left_corner
    @@tiles[31] = @sandgrass_bottom_right_corner
  end
end
