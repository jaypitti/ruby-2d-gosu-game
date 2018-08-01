class GameHandler
  attr_accessor :world
  def initialize game
    @game = game
  end

  def getGame
    return @game
  end

  def getGameCamera
    return @game.getGameCamera
  end

  def getWidth
    @game.width
  end

  def getHeight
    @game.height
  end

  def setWorld world
    @world = world
  end

  def getWorld
    return @world
  end
end
