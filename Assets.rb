require_relative './SpriteSheet.rb'

class Assets
  attr_accessor :player, :stone, :grass
  def initialize
    @w = @h = 32
    @spritesheet = SpriteSheet.new
    @player = @spritesheet.playerCrop 0, 0, @w, @h
    @stone = @spritesheet.tileCrop @w, @h, @w, @h
    @grass = @spritesheet.tileCrop @w * 1, @h * 2, @w, @h
  end

end
