require './Creature.rb'
require './Animation'
require 'ruby2d'
require 'gosu'

class Player < Creature
  def initialize window, x, y
    super window, x, y, Creature.DEFAULT_WIDTH_SCALE, Creature.DEFAULT_HEIGHT_SCALE
    @widow = window
    @xmove = @ymove = 0
    # image
    @assets = Assets.new
    @animation_down = Animation.new(100, @assets.player_down)
    @animation_up = Animation.new(100, @assets.player_up)
    @animation_x = Animation.new(100, @assets.player_x)

    @width = @height = 32
    # Only defined twice so others would know what @s is
    @scale = @s = 2
    # center image
    @x = x * 64
    @y = y * 64
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false

    @cooldown = 800
    @attacktimer = 800
    @lastAttack = 0

  end

  def update
    super
    playerMove
    move

    @animation_down.update
    @animation_up.update
    @animation_x.update

    @window.getGameCamera.centerOnEntity self

    checkAttacks
  end

  def checkAttacks
    @cooldown = 800
    @attacktimer += Gosu::milliseconds - @lastAttack
    @lastAttack = Gosu::milliseconds
    if (@attacktimer < @cooldown)
      puts "ASDFASDFASFD"
      return
    else
      # Rectangle.new(x: 0, y: 0, width: 200, height: 100, z: 0, color: 'white')
      cb = gCB(0,0)
      rect = Rectangle.new()
      arSize = 20
      rect.width = arSize
      rect.height = arSize

      if @window.getGame.button_down? Gosu::KbUp
        rect.x = cb[:x] + cb[:width] / 2 - arSize / 2
        rect.y = cb[:y] - arSize
      elsif @window.getGame.button_down? Gosu::KbDown
        rect.x = cb[:x] + cb[:width] / 2 - arSize / 2
        rect.y = cb[:y] + cb[:height]
      elsif @window.getGame.button_down? Gosu::KbLeft
        rect.x = cb[:x] - arSize
        rect.y = cb[:y] + cb[:height] / 2 - arSize / 2
      elsif @window.getGame.button_down? Gosu::KbRight
        rect.x = cb[:x] + cb[:width]
        rect.y = cb[:y] + cb[:height] / 2 - arSize / 2
      else
        return
      end
    @attacktimer = 0
      for e in @window.getWorld.getEntityManager.getEntities
        next if e == @window.getWorld.getEntityManager.getPlayer
          if (
            e.gCB(0,0)[:x] < rect.x + rect.width &&
            e.gCB(0,0)[:x] + e.gCB(0,0)[:width] > rect.x &&
            e.gCB(0,0)[:y] < rect.y + rect.height &&
            e.gCB(0,0)[:height] + e.gCB(0,0)[:y] > rect.y)
            e.hit(3)
            return
          end
      end
    end
  end

  def getX
    return @x
  end

  def setX v
    @x = v
  end

  def setY v
    @x = v
  end

  def getY
    return @y
  end

  def getWidth
    return @width
  end

  def getHeight
    return @height
  end

  def move
    super
  end
  def playerAttack
    @sound = Gosu::Song.new('sounds/running.mp3')
    @frame += 1
    if !@moving
      @sound.play true
      @xmove = 0
      @ymove = 0
    end
    if
      @window.getGame.button_down? Gosu::KbA
      @direction = :left
      @moving = true
      @xmove = -@speed
    elsif
      @window.getGame.button_down? Gosu::KbD
      @direction = :right
      @moving = true
      @xmove = @speed
    elsif
      @window.getGame.button_down? Gosu::KbW
      @direction = :up
      @moving = true
      @ymove = -@speed
    elsif
      @window.getGame.button_down? Gosu::KbS
      @direction = :down
      @moving = true
      @ymove = @speed
    end
  end

  def die
  end

  def playerMove
    @sound = Gosu::Song.new('sounds/running.mp3')
    @frame += 1
    if !@moving
      @sound.play true
      @xmove = 0
      @ymove = 0
    end
    if
      @window.getGame.button_down? Gosu::KbA
      @direction = :left
      @moving = true
      @xmove = -@speed
    elsif
      @window.getGame.button_down? Gosu::KbD
      @direction = :right
      @moving = true
      @xmove = @speed
    elsif
      @window.getGame.button_down? Gosu::KbW
      @direction = :up
      @moving = true
      @ymove = -@speed
    elsif
      @window.getGame.button_down? Gosu::KbS
      @direction = :down
      @moving = true
      @ymove = @speed
    else
      @moving = false
    end
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    # f = @frame % @animated.size
    image = @assets.player
    if @moving
      if @direction == :left
        @animation_x.getFrame.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :right
        @animation_x.getFrame.draw @x + (@width * 2) - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, -2, 2
      elsif @direction == :up
        @animation_up.getFrame.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :down
        @animation_down.getFrame.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      end
    else
      if @direction == :left
        image.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :right
        image.draw @x + (@width * 2) - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, -2, 2
      elsif @direction == :up
        image.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :down
        image.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      end
    end
  end
end
