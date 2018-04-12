require 'gosu'
require './Player.rb'
require './World.rb'
require './Camera.rb'

class Game < Gosu::Window

  module ZOrder
    BACKGROUND, ITEMS, PLAYER, UI = *0..3
  end

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "DEV"
    @windowW = width
    @windowH = height
    @width = @height = 32
    @player = Player.new self, 0, 0
    @camera = Camera.new self, 0, 0
    @world = World.new self, "./worlds/world1.txt",  20, 20
    @background_image = Gosu::Image.new 'images/tilesets/bg.png', :tileable => true
    @tiles = Gosu::Image.load_tiles 'images/tilesets/bg.png', @width, @height

  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def getGameCamera
    return @camera
  end

  def getWidth
    return @width
  end

  def getHeight
    return @height
  end

  def getWindowWidth
    return @windowW
  end

  def getWindowHeight
    return @windowH
  end

  def update
    @camera.move(1, 1)
    @player.update
  end

  def draw
    @world.draw
    @player.draw
  end

end

Game.new.show
