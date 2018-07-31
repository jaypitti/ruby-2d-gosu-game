class SpriteSheet
  def initialize
    # FUTURE SPRITES @idle = Gosu::Image.load_tiles("player-1.png", @width, @height)
    @move = Gosu::Image.new 'images/spritesheets/player-1.png'
    @sheet = Gosu::Image.new 'images/tilesets/bg.png'
    @enemies = Gosu::Image.new 'images/spritesheets/zombies.png'
  end

  def tileCrop x, y, width, height
    return @sheet.subimage x, y, width, height
  end

  def playerCrop x, y, width, height
    return @move.subimage x, y, width, height
  end

  def enemycut x, y, width, height
    return @enemies.subimage x, y, width, height
  end
end
