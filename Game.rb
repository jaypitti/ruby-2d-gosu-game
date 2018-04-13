require 'gosu'
require './Player.rb'
require './World.rb'
require './Camera.rb'
require './Tree.rb'
require './GameHandler'

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
    @handler = GameHandler.new self
    @camera = Camera.new @handler, 0, 0
    @world = World.new @handler, "./worlds/world1.txt",  20, 20
    @handler.setWorld @world
    @background_image = Gosu::Image.new 'images/tilesets/bg.png', :tileable => true
    @tiles = Gosu::Image.load_tiles 'images/tilesets/bg.png', @width, @height
    @tree = Tree.new @handler, 5, 5, 0, 0

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
    @camera.move(0, 0)
    @world.update
  end

  def draw
    @world.draw
  end

end

Game.new.show
