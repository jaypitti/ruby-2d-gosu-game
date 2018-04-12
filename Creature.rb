require_relative './Entity.rb'

class Creature < Entity
  class << self
    attr_accessor :DEFAULT_WIDTH_SCALE, :DEFAULT_HEIGHT_SCALE
  end

  @@DEFAULT_HEALTH = 10
  @@DEFAULT_SPEED = 3
  @DEFAULT_WIDTH_SCALE = @DEFAULT_HEIGHT_SCALE = 1

  def initialize window, x, y, width, height
    super window, x, y, @DEFAULT_WIDTH_SCALE, @DEFAULT_HEIGHT_SCALE
    @@xmove = @@ymove = 0
    @@health = @@DEFAULT_HEALTH
    @@speed = @@DEFAULT_SPEED
  end

  def update
  end

  def move
    @@x += @@xmove
    @@y += @@ymove
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
