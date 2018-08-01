require './Entity'

class Camera
  def initialize window, xOffset, yOffset
    @window = window
    @xOffset = xOffset
    @yOffset = yOffset
  end

  def move x, y
    @xOffset += x
    @yOffset += y
  end

  def getXoffset
    return @xOffset
  end

  def getYoffset
    return @yOffset
  end

  def checkMapBounds
    if @xOffset < 0
      @xOffset = 0
    elsif @xOffset > @window.getWorld.getWidth * 64 - @window.getWidth
      @xOffset = @window.getWorld.getWidth * 64 - @window.getWidth
    end
    if @yOffset < 0
      @yOffset = 0
    elsif @yOffset > @window.getWorld.getHeight * 64 - @window.getHeight
      @yOffset = @window.getWorld.getHeight * 64 - @window.getHeight
    end
  end

  def centerOnEntity e
    @xOffset = e.getX - @window.getWidth/2 + e.getWidth/2
    @yOffset = e.getY - @window.getHeight/2 + e.getHeight/2
    checkMapBounds
  end

end
