require 'gosu'
require 'pry'

class Entity
  @@DEFAULT_HEALTH = 3
  class << self
    attr_accessor :x, :y
  end
  def initialize window, x, y, w, h
    @window = window
    @w = 1
    @h = 1
    @health = @@DEFAULT_HEALTH
    @active = true
    @x = x * 64;
    @y = y * 64;


  end

  def entityCollided xOffset, yOffset
    for e in @window.getWorld.getEntityManager.getEntities
        next if e == @window.getWorld.getEntityManager.getPlayer
        next if e == self
        if (
          e.gCB(0,0)[:x] < gCB(xOffset,xOffset)[:x] + gCB(0,0)[:width] &&
          e.gCB(0,0)[:x] + e.gCB(0,0)[:width] > gCB(0,0)[:x] &&
          e.gCB(0,0)[:y] < gCB(xOffset,xOffset)[:y] + gCB(xOffset,xOffset)[:height] &&
          e.gCB(0,0)[:height] + e.gCB(0,0)[:y] > gCB(xOffset,xOffset)[:y])
          if (e.gCB(0,0)[:x] < gCB(xOffset,yOffset)[:x])
            @x += 1
            return true
          end
          if (e.gCB(0,0)[:x] > gCB(xOffset,yOffset)[:x])
            @x += -1
            return true
          end
          if (e.gCB(0,0)[:y] < gCB(xOffset,yOffset)[:y])
            @y += 1
            return true
          end
          if (e.gCB(0,0)[:y] > gCB(xOffset,yOffset)[:y])
            @y += -1
            return true
          end
        end
      end
      return false
  end

  def gCB xOffset, yOffset
    obj = {x: (@x) + xOffset, y: (@y) + yOffset, width: 30, height: 24}
    return obj
  end

  def update
  end

  def draw
  end

  def die
  end

  def is_player
    return false
  end

  def hit dmg
    @health = @health - dmg
    if @health <= 0
      @active = false
      die
    end
  end

  def getHealth
    return @health
  end

  def getActive
    return @active
  end

end
