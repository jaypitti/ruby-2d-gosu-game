require './State.rb'
require './Player.rb'
require './World.rb'
require './Camera.rb'
require './GameHandler'

class GameState < State
  def initialize game, handler
    @handler = handler

    @world = World.new @handler, "./worlds/world2.txt",  40, 40
    @handler.setWorld @world
  end

  def getGameCamera
    return @camera
  end

  def update
    @handler.getGameCamera.move(0, 0)
    @world.update
  end

  def draw
    @world.draw
  end

end
