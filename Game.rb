require 'gosu'
require './Player.rb'
require './World.rb'
require './Camera.rb'
require './GameHandler'
require './State'
require './GameState'
require 'gosu'

class Game < Gosu::Window

  module ZOrder
    BACKGROUND, ITEMS, PLAYER, UI = *0..3
  end

  def initialize width=800, height=600, fullscreen=false
    super
    self.caption = "DEV"

    @handler = GameHandler.new self

    @camera = Camera.new @handler, 0, 0
    @gameState = GameState.new @handler, @handler
    State.setState @gameState

    @windowW = width
    @windowH = height
    @width = @height = 32
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
    if State.getState != nil
      @gameState.update
    end
  end

  def draw
    if State.getState != nil
      @gameState.draw
    end
  end

end

Game.new.show
