require 'gosu'
require_relative './Assets.rb'
require_relative './Player.rb'

class Game < Gosu::Window

  module ZOrder
    BACKGROUND, ITEMS, PLAYER, UI = *0..3
  end

  def initialize width=1200, height=1000, fullscreen=false
    super
    self.caption = "DEV"

    @width = @height = 32

    @player = Player.new self, 10, 10
    @assets = Assets.new
    @background_image = Gosu::Image.new('images/tilesets/bg.png', :tileable => true)
    @tiles = Gosu::Image.load_tiles('images/tilesets/bg.png', @width, @height)
  end

  def button_down id
    close if id == Gosu::KbEscape
  end

  def update
    @player.update
  end

  def draw
    @assets.grass.draw(0,0, 5)
    50.times do |x|
      50.times do |y|
        @assets.grass.draw((x * 32), (y * 32), 0, 1, 1)
      end
    end
    @player.draw
  end

end

Game.new.show
