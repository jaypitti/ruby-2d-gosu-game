require "gosu"

class Entity
  class << self
    attr_accessor :x, :y
  end
  def initialize window, x, y, w, h 
    @@x = x;
    @@y = y;
  end

  def update
  end

  def draw
  end

end

class Creature < Entity
  class << self
    attr_accessor :DEFAULT_WIDTH_SCALE, :DEFAULT_HEIGHT_SCALE 
  end

  @DEFAULT_HEALTH = 10
  @DEFAULT_SPEED = 10
  @DEFAULT_WIDTH_SCALE = @DEFAULT_HEIGHT_SCALE = 1

  def initialize window, x, y, width, height
    super window, x, y, @DEFAULT_WIDTH_SCALE, @DEFAULT_HEIGHT_SCALE
    @@xmove = @@ymove = 0
    @health = @DEFAULT_HEALTH
    @speed = @DEFAULT_SPEED
  end

  def update
  end

  def move
    @@x += @@xmove
    @@y += @@ymove
  end

  def getHealth
    return @health
  end

  def setHealth newHealth 
    @health = newHealth
  end

  def getSpeed
    return @speed
  end

  def setSpeed newSpeed
    @speed = newSpeed
  end
end

class SpriteSheet
  def initialize
    # FUTURE SPRITES @idle = Gosu::Image.load_tiles("player-1.png", @width, @height)
    @move = Gosu::Image.new "player-1.png"
    @sheet = Gosu::Image.new "bg.png"
  end

  def tileCrop x, y, width, height
    return @sheet.subimage x, y, width, height
  end

  def playerCrop x, y, width, height
    return @move.subimage x, y, width, height
  end
end

class Assets
  attr_accessor :player, :stone, :grass
  def initialize
    @w = @h = 32
    @spritesheet = SpriteSheet.new
    @player = @spritesheet.playerCrop 0, 0, @w, @h
    @stone = @spritesheet.tileCrop @w, @h, @w, @h
    @grass = @spritesheet.tileCrop @w * 10, @h * 10, @w, @h
  end

end

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
    @speed = 3
    @frame = 0
    @moving = false

    @animated = Gosu::Image.load_tiles "player-1.png", @width, @height
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
      @@xmove = -@speed
    elsif @window.button_down? Gosu::KbRight
      puts 'RIGHT'
      @direction = :right
      @moving = true
      @@xmove = @speed
    elsif @window.button_down? Gosu::KbUp
      puts 'UP'
      @direction = :up
      @moving = true
      @@ymove = -@speed
    elsif @window.button_down? Gosu::KbDown
      puts 'DOWN'
      @direction = :down
      @moving = true
      @@ymove = @speed
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

class Game < Gosu::Window

  module ZOrder
    BACKGROUND, ITEMS, PLAYER, UI = *0..3
  end

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "DEV"

    @width = @height = 32

    @player = Player.new self, 10, 10
    @assets = Assets.new
    @background_image = Gosu::Image.new("bg.png", :tileable => true)
    @tiles = Gosu::Image.load_tiles("bg.png", @width, @height)
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @player.update
  end

  def draw
    @assets.grass.draw(0,0, 5)
    30.times do |x|
      30.times do |y|
        @tiles[200].draw((x * 32), (y * 32), 0, 1, 1)
      end
    end
    @player.draw
  end

end

Game.new.show
