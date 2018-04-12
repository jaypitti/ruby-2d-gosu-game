class GameHandler
  attr_accessor :world
  def initialize window
    @window = window
  end

  def getGame
    return @window
  end

  def getGameCamera
    return @window.getGameCamera
  end

  def getWidth
    @window.width
  end

  def getHeight
    @window.height
  end

  def setWorld world
    @world = world
  end

  def getWorld
    return @world
  end
end
