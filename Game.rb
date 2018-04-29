require 'gosu'
require 'celluloid/io'
require 'socket'
require './Player.rb'
require './Monster.rb'
require './World.rb'
require './Camera.rb'
require './GameHandler'
require './State'
require './GameState'
require 'gosu'
require 'pry'

class Client
  include Celluloid::IO

  def initialize(server, port)
    begin
      @socket = TCPSocket.new(server, port)
    rescue
      $error_message = "Cannot find game server."
    end
  end

  def send_message(message)
    @socket.write(message) if @socket
  end

  def read_message
    @socket.readpartial(4096) if @socket
  end
end

class Game < Gosu::Window

  module ZOrder
    BACKGROUND, ITEMS, PLAYER, UI = *0..3
  end

  def initialize name, server, port
    super 800, 600, false

    @client = Client.new(server, port)

    self.caption = "DEV"

    @font = Gosu::Font.new(self, 'Courier New', 20)

    @name = name

    @handler = GameHandler.new self
    @player = Player.new(@handler, 5, 5)
    @gameState = GameState.new @handler, @handler, @player
    State.setState @gameState

    @windowW = width
    @windowH = height
    @width = @height = 32

    @messages = Array.new

    @player = @handler.getWorld.getEntityManager.getPlayer
    @players = Hash.new

    @valid_sprites = Array.new

    add_to_message_queue('obj', @handler.getWorld.getEntityManager.getPlayer)
  end

  def add_to_message_queue(msg_type, sprite)
    @messages << "#{msg_type}|#{sprite.uuid}|#{sprite.type}|1|#{@name}|#{sprite.x}|#{sprite.y}|#{sprite.health}|10|#{sprite.active}"
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def draw_player_names
    @font.draw("#{@name}", @handler.getWorld.getEntityManager.getPlayer.getX - @handler.getGameCamera.getXoffset + 15, @handler.getWorld.getEntityManager.getPlayer.getY - @handler.getGameCamera.getYoffset - 20, 5, 1, 1, Gosu::Color::AQUA)
    @players.keys.each_with_index do |name, i|
      if @players[name] != @player && @players[name].health >= 1
        @font.draw("#{name}", @players[name].x - @handler.getGameCamera.getXoffset + 15, @players[name].y - @handler.getGameCamera.getYoffset - 20, 5)
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
    server
  end

  def draw
    draw_player_names
    if State.getState != nil
      @gameState.draw
    end
  end

  def server
    add_to_message_queue('obj', @handler.getWorld.getEntityManager.getPlayer)

    @client.send_message @messages.join("\n")
    @messages.clear
    i = 1
    if msg = @client.read_message
    @valid_sprites.clear
    data = msg.split("\n")
    data.each do |row|
      sprite = row.split("|")
      if sprite.size == 9
        player = sprite[3]
        @valid_sprites << sprite[0]
        case sprite[1]
        when 'player'
          unless player == @player
            if @players[player]
               @players[player].warp_to(sprite[4], sprite[5], sprite[6])
               @player.active = sprite[8]
            else
              @players[player] = Player.from_sprite(@handler, sprite)
              if @player.uuid == sprite[0]
              else
                @handler.getWorld.getEntityManager.addEntity(@players[player])
              end
            end
          else
            @player.points = sprite[7].to_i
          end
        end
      end
    end
  end
end
end

name = ARGV[0]
server = ARGV[1]
port = ARGV[2] || 1234
game = Game.new name, server, port
game.show
