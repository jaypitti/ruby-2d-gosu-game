require './State.rb'
require './Player.rb'
require './World.rb'
require './Camera.rb'
require './GameHandler'

class GameState < State
  def initialize game, handler, player
    @handler = handler

    @world = World.new @handler, "./worlds/world2.txt",  40, 40, player
    @handler.setWorld @world
  end

  def getGameCamera
    return @camera
  end

  def update
    if @handler.getGameCamera
    @handler.getGameCamera.move(0, 0)
  end
    @world.update
  end

  def draw
    @world.draw
  end

end
