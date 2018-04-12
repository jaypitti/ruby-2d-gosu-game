require './Creature.rb'
require './Animation'

class Player < Creature
  def initialize window, x, y
    super window, x, y, Creature.DEFAULT_WIDTH_SCALE, Creature.DEFAULT_HEIGHT_SCALE
    @widow = window
    @@xmove = @@ymove = 10
    # image
    @assets = Assets.new
    @animation_down = Animation.new(250, @assets.player_down)
    @animation_up = Animation.new(250, @assets.player_up)
    @animation_x = Animation.new(250, @assets.player_x)

    @width = @height = 32
    # Only defined twice so others would know what @s is
    @scale = @s = 2
    # center image
    @@x = @window.getWidth/2  - @width/2 + x
    @@y = @window.getHeight/2  - @height/2 + y
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false

    @animated = Gosu::Image.load_tiles './images/spritesheets/player-1.png', @width, @height
  end

  def update
    super
    playerMove
    move

    @animation_down.update
    @animation_up.update
    @animation_x.update

    @window.getGameCamera.centerOnEntity self
  end

  def getX
    return @@x
  end

  def getY
    return @@y
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

  def playerMove
    @frame += 1
    @moving = false
    if !@moving
      @@xmove = 0
      @@ymove = 0
    end
    if @window.getGame.button_down? Gosu::KbLeft
      puts "LEFT"
      @direction = :left
      @moving = true
      @@xmove = -@@speed
    end
    if @window.getGame.button_down? Gosu::KbRight
      puts 'RIGHT'
      @direction = :right
      @moving = true
      @@xmove = @@speed
    end
    if @window.getGame.button_down? Gosu::KbUp
      puts 'UP'
      @direction = :up
      @moving = true
      @@ymove = -@@speed
    end
    if @window.getGame.button_down? Gosu::KbDown
      puts 'DOWN'
      @direction = :down
      @moving = true
      @@ymove = @@speed
    end
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    # f = @frame % @animated.size
    f = Gosu.milliseconds / 100 % @animated.size
    image = @assets.player
    if @moving
      if @direction == :left
        @animation_x.getFrame.draw @@x - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :right
        @animation_x.getFrame.draw @@x + (@width * 2) - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, -2, 2
      elsif @direction == :up
        @animation_up.getFrame.draw @@x - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :down
        @animation_down.getFrame.draw @@x - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, 2, 2
      end
    else
      if @direction == :left
        image.draw @@x - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :right
        image.draw @@x + (@width * 2) - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, -2, 2
      elsif @direction == :up
        image.draw @@x - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, 2, 2
      elsif @direction == :down
        image.draw @@x - @window.getGameCamera.getXoffset, @@y - @window.getGameCamera.getYoffset, 1, 2, 2
      end
    end
  end
end
