require 'gosu'

class Animation

  def initialize speed, frames
    @speed = speed
    @frames = frames
    @i = 0
    @timer = 0
    @lastTime = Gosu::milliseconds
  end

  def update
    @timer += Gosu::milliseconds - @lastTime
    @lastTime = Gosu::milliseconds
    if @timer > @speed
      @i += 1
      @timer = 0
      if @i >= @frames.length
         @i = 0
      end
    end
  end

  def getFrame
    return @frames[@i]
  end


end
