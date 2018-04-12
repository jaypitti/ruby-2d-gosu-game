require_relative './Creature.rb'

class Player < Creature
  def initialize window, x, y
    super window, x, y, Creature.DEFAULT_WIDTH_SCALE, Creature.DEFAULT_HEIGHT_SCALE
    @window = window
    # image
    @assets = Assets.new
    @width = @height = 32
    # Only defined twice so others would know what @s is
    @scale = @s = 2
    # center image
    @@x = @window.width/2  - @width/2 + x
    @@y = @window.height/2 - @height/2 + y
    # direction and movement
    @direction = :right
    @frame = 0
    @moving = false

    @animated = Gosu::Image.load_tiles './images/spritesheets/player-1.png', @width, @height
  end

  def update
    super
    playerMove()
    move()
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
    if @window.button_down? Gosu::KbLeft
      puts "LEFT"
      @direction = :left
      @moving = true
      @@xmove = -@@speed
    end
    if @window.button_down? Gosu::KbRight
      puts 'RIGHT'
      @direction = :right
      @moving = true
      @@xmove = @@speed
    end
    if @window.button_down? Gosu::KbUp
      puts 'UP'
      @direction = if @window.button_down? Gosu::KbRight then :right else :left end
      @moving = true
      @@ymove = -@@speed
    end
    if @window.button_down? Gosu::KbDown
      puts 'DOWN'
      @direction = if @window.button_down? Gosu::KbLeft then :left else :right end
      @moving = true
      @@ymove = @@speed
    end
  end

  def draw
    # @move and @idle are the same size,
    # so we can use the same frame calc.
    # f = @frame % @animated.size
    f = Gosu.milliseconds / 100 % @animated.size
    if @moving
      image = @animated[f]
    else
      image = @assets.player
    end
    if @direction == :left
      image.draw @@x, @@y, 2, 2, 2
    elsif @direction == :right
      image.draw @@x + (@width * 2), @@y, 2, -2, 2
    elsif @direction == :up
      image.draw @@x, @@y, 2, 2, 2
    elsif @direction == :down
      image.draw @@x, @@y, 2, 2, 2
    end
  end
end
