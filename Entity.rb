require 'gosu'

class Entity
  class << self
    attr_accessor :x, :y
  end
  def initialize window, x, y, w, h
    @window = window
    @w = 1
    @h = 1
    @x = x * 64;
    @y = y * 64;
  end

  def entityCollided xOffset, yOffset
    p = @window.getWorld.getEntityManager.getPlayer
    for e in @window.getWorld.getEntityManager.getEntities
        next if e == @window.getWorld.getEntityManager.getPlayer
        if (
          e.gCB(0,0)[:x] < gCB(xOffset,xOffset)[:x] + gCB(0,0)[:width] &&
          e.gCB(0,0)[:x] + e.gCB(0,0)[:width] > gCB(0,0)[:x] &&
          e.gCB(0,0)[:y] < gCB(xOffset,xOffset)[:y] + gCB(xOffset,xOffset)[:height] &&
          e.gCB(0,0)[:height] + e.gCB(0,0)[:y] > gCB(xOffset,xOffset)[:y])
          puts "collision"
          collided = true
          if (e.gCB(0,0)[:x] < gCB(xOffset,xOffset)[:x])
            p.setX(@x += 1)
            return true
          end
          if (e.gCB(0,0)[:x] > gCB(xOffset,xOffset)[:x])
            p.setX(@x += -1)
            return true
          end
          if (e.gCB(0,0)[:y] < gCB(xOffset,xOffset)[:y])
            p.setY(@y += 1 * 2)
            return true
          end
          if (e.gCB(0,0)[:y] > gCB(xOffset,xOffset)[:y])
            p.setY(@y += 1 * 2)
            return true
          end
          puts e.gCB(0,0), gCB(xOffset,yOffset)
        end
      # puts e.getCollisionBounds(0,0), getCollisionBounds(xOffset,yOffset)
      end
      return false
  end

  def gCB xOffset, yOffset
    obj = {x: (@x) + xOffset, y: (@y) + yOffset , width: 20, height: 20}

    return obj

    # arr = [@x + xOffset,@y + yOffset, @w, @h]
    # return arr
    # return Gosu::draw_quad(@x + 64 + xOffset, @y + 64 + yOffset, 0x00_000000,
    #                           @x + 64 + xOffset + @w, @y + 64 + yOffset, 0x00_000000,
    #                           @x + 64 + xOffset, @y + 64 + yOffset - @h, 0x00_000000,
    #                           @x + 64 + xOffset + @w, @y + 64 + yOffset - @h, 0x00_000000, 1)
  end

  def update
  end

  def draw
  end

end
