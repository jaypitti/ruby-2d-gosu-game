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

  def centerOnEntity e
    @xOffset = e.getX - @window.width/2 + e.getWidth/2
    @yOffset = e.getY - @window.height/2 + e.getHeight/2
  end

end
