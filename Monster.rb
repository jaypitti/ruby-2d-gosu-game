require './Creature.rb'
require './Animation'
require 'gosu'

class Monster < Creature

  def self.from_sprite(window, sprite)
    if sprite[0].length == 36
      Player.new(window, 5, 5, sprite[0])
    end
  end

  def initialize window, x, y
    super window, x, y, Creature.DEFAULT_WIDTH_SCALE, Creature.DEFAULT_HEIGHT_SCALE
    @widow = window
    @speed = 1
    @xmove, @ymove = 0,0
    # image
    @assets = Assets.new
    @animation_down = Animation.new(100, @assets.zom_down)
    @animation_up = Animation.new(100, @assets.zom_up)
    @animation_x = Animation.new(100, @assets.zom_x)

    @width = @height = 64
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
    monstermove
    move

    @animation_down.update
    @animation_up.update
    @animation_x.update

    checkAttacks
  end

  def checkAttacks
    @cooldown = 800
    @attacktimer += Gosu::milliseconds - @lastAttack
    @lastAttack = Gosu::milliseconds
    if (@attacktimer < @cooldown)
      return
    else
      # Rectangle.new(x: 0, y: 0, width: 200, height: 100, z: 0, color: 'white')
      cb = gCB(0,0)
      rect = {x: 0, y: 0, w: 32, h: 32}
      arSize = 20
      rect[:w] = arSize
      rect[:h] = arSize

      if @window.getGame.button_down? Gosu::KbUp
        rect[:x] = cb[:x] + cb[:width] / 2 - arSize / 2
        rect[:y] = cb[:y] - arSize
      elsif @window.getGame.button_down? Gosu::KbDown
        rect[:x] = cb[:x] + cb[:width] / 2 - arSize / 2
        rect[:y] = cb[:y] + cb[:height]
      elsif @window.getGame.button_down? Gosu::KbLeft
        rect[:x] = cb[:x] - arSize
        rect[:y] = cb[:y] + cb[:height] / 2 - arSize / 2
      elsif @window.getGame.button_down? Gosu::KbRight
        rect[:x] = cb[:x] + cb[:width]
        rect[:y] = cb[:y] + cb[:height] / 2 - arSize / 2
      else
        return
      end
    @attacktimer = 0
      for e in @window.getWorld.getEntityManager.getEntities
        next if e == @window.getWorld.getEntityManager.getPlayer
          if (
            e.gCB(0,0)[:x] < rect[:x] + rect[:w] &&
            e.gCB(0,0)[:x] + e.gCB(0,0)[:width] > rect[:x] &&
            e.gCB(0,0)[:y] < rect[:y] + rect[:y] &&
            e.gCB(0,0)[:height] + e.gCB(0,0)[:y] > rect[:y])
            e.hit(3)
            return
          end
      end
    end
  end

  def getWidth
    return @width
  end

  def getHeight
    return @height
  end

  def chaseY
    @player = @window.getWorld.getEntityManager.getPlayer
    @moving = true;
    @xSpeed = 2;
    if @window.getWorld.getEntityManager.getPlayer.getX < @x
      @xmove = -@xSpeed;
      moveX :left;
      @direction = :left;
    end
    if @window.getWorld.getEntityManager.getPlayer.getX > @x
      @xmove = @xSpeed;
      moveX :right;
      @direction = :right;
    end
  end

  def chaseX
    @player = @window.getWorld.getEntityManager.getPlayer
    @moving = true;
    @ySpeed = 2;
    if @window.getWorld.getEntityManager.getPlayer.getY < @y - 2
      @ymove = -@ySpeed;
      moveY :up;
      @direction = :up;
    end
    if @window.getWorld.getEntityManager.getPlayer.getY > @y + 2
      @ymove = @ySpeed;
      moveY :down;
      @direction = :down;
    end
  end

  def euclidean_distance(p1,p2)
    sum_of_squares = 0
    p1.each_with_index do |p1_coord,index|
      sum_of_squares += (p1_coord - p2[index]) ** 2
    end
    return Math.sqrt( sum_of_squares )
  end

  def move
    @player = @window.getWorld.getEntityManager.getPlayer
    @p1 = [@x, @y]
    @p2 = [@player.getX, @player.getY]
    @distance = euclidean_distance @p1, @p2
      if !entityCollided @xmove, 0
        if @distance < 150 && @distance > 40
           puts @distance
           chaseX
        else
        moveX
      end
      end
      if !entityCollided 0, @ymove
        if @distance < 150 && @distance > 40
           puts @distance
           chaseY
        else
        moveY
      end
      end
    end


  def getY
    return @y
  end

  def getX
    return @x
  end

  def die
  end

  def monstermove
    @cooldown = 800
    @attacktimer += Gosu::milliseconds - @lastAttack
    @lastAttack = Gosu::milliseconds
    if (@attacktimer < @cooldown)
      return
    else
      m = rand(0..10)
      @frame += 1
      if !@moving
        @xmove = 0
        @ymove = 0
      end
      if m == 0..1
        @direction = :left
        @moving = true
        @xmove = -@speed
      elsif m == 2..3
        @direction = :right
        @moving = true
        @xmove = @speed
      elsif m == 4..5
        @direction = :up
        @moving = true
        @ymove = -@speed
      elsif move == 6..7
        @direction = :down
        @moving = true
        @ymove = @speed
      elsif move == 8..11
        @moving = false
        @xmove = 0
        @ymove = 0
      else
        @moving = false
      end
      @attacktimer = 0
    end
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    # f = @frame % @animated.size
    image = @assets.zombie
    if @moving
      if @direction == :left
        @animation_x.getFrame.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :right
        @animation_x.getFrame.draw @x + (@width) - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, -2, 2
      elsif @direction == :up
        @animation_up.getFrame.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :down
        @animation_down.getFrame.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      end
    else
      if @direction == :left
        image.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :right
        image.draw @x + (@width) - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, -2, 2
      elsif @direction == :up
        image.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :down
        image.draw @x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2
      end
    end
  end
end
