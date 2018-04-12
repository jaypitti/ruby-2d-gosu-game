require_relative './Entity.rb'

class Creature < Entity
  class << self
    attr_accessor :DEFAULT_WIDTH_SCALE, :DEFAULT_HEIGHT_SCALE
  end

  @@xmove = 0
  @@ymove = 0
  @@DEFAULT_HEALTH = 10
  @@DEFAULT_SPEED = 3
  @DEFAULT_WIDTH_SCALE = @DEFAULT_HEIGHT_SCALE = 1

  def initialize window, x, y, width, height
    super window, x, y, @DEFAULT_WIDTH_SCALE, @DEFAULT_HEIGHT_SCALE
    @bx = 16
    @by = 32
    @bw = 32
    @bh = 32
    @window = window
    @@health = @@DEFAULT_HEALTH
    @@speed = @@DEFAULT_SPEED
  end

  def update
  end

  def move
    moveX
    moveY
  end

  def collided xvar, yvar
    x = @window.getWorld.getTile(xvar, yvar)
    if x == 0
      return false
    else
      return true
    end
  end

  def moveX
      if @@xmove > 0
        puts "RUNNING RIGHT"
        tx = (@@xmove + @@x + @bx + @bw) / 64
        if !collided(tx, ((@@y + @by) / 64)) and !collided(tx, ((@@y + @by + @bh) / 64))
          @@x += @@xmove
        else
          @@x = tx * 64 - @bx - @bw - 1
        end
      elsif @@xmove < 0
        puts "RUNNING LEFT"
        tx = (@@xmove + @@x + @bx) / 64
          if !collided(tx, ((@@y + @by) / 64)) and !collided(tx, ((@@y + @by + @bh) / 64))
            @@x += @@xmove
          else
            @@x = tx * 64 + 64 - @bx
          end
        end
      end

  def moveY
    if @@ymove > 0
      ty = (@@y + @@ymove + @by + @bh) / 64
      if !collided((@@x + @bx) / 64, ty) and !collided((@@x + @bx + @bw) / 64, ty)
        @@y += @@ymove
      else
        @@y = ty * 64 - @by - @bw - 1
      end
    elsif @@ymove < 0
      ty = (@@y + @@ymove + @by) / 64
      if !collided((@@x + @bx) / 64, ty) and !collided((@@x + @bx + @bw) / 64, ty)
        @@y += @@ymove
      else
        @@y = ty * 64 + 64 - @by
      end
    end
  end

  def getHealth
    return @@health
  end

  def setHealth newHealth
    @@health = newHealth
  end

  def getSpeed
    return @@speed
  end

  def setSpeed newSpeed
    @@speed = newSpeed
  end
end
