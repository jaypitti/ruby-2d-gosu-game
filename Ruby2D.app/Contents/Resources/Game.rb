require 'gosu'
require 'socket'
require './Player.rb'
require './Monster.rb'
require './World.rb'
require './Camera.rb'
require './GameHandler'
require './State'
require './GameState'

class Game < Gosu::Window

  module ZOrder
    BACKGROUND, ITEMS, PLAYER, UI = *0..3
  end

  def initialize name, server, port
    super 800, 600, false

    self.caption = "DEV"

    @font = Gosu::Font.new(self, 'Courier New', 20)

    @name = name

    @handler = GameHandler.new self
    @player = Player.new(@handler, 5, 5, name)
    @gameState = GameState.new @handler, @handler, @player
    State.setState @gameState

    @windowW = width
    @windowH = height
    @width = @height = 32

    @messages = Array.new

    @players = Hash.new

    @valid_sprites = Array.new
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def draw_player_names
    if @player.active
      @font.draw("#{@name} - #{@player.health} / #{@player.defaulthealth} ", @player.getX - @handler.getGameCamera.getXoffset + 15, @player.getY - @handler.getGameCamera.getYoffset - 20, 5, 1, 1, Gosu::Color::AQUA)
    end
    @players.keys.each_with_index do |name, i|
      if @players[name] != @player && @players[name].health >= 1
        @font.draw("#{name} - #{@players[name].health} / #{@players[name].defaulthealth}", @players[name].x - @handler.getGameCamera.getXoffset + 15, @players[name].y - @handler.getGameCamera.getYoffset - 20, 5)
      end
    end
  end

  def getGameCamera
    return @handler.getWorld.getEntityManager.getPlayer.getCamera
  end

  def getWidth
    return @width
  end

  def deletePlayer player
    @players.each do |e|
      if player == e[1]
        @players.delete(e)
      end
    end
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
    draw_player_names
    if State.getState != nil
      @gameState.draw
    end
  end

  def to_bool(str)
    if str.downcase == "true"
      return true
    else
      return false
    end
  end
end

#name = ARGV[0]
server = ARGV[1]
port = ARGV[2] || 1234
#game = Game.new name, server, port
#game.show
