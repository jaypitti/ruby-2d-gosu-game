require './StaticEntity.rb'
require './Assets.rb'

class Tree < StaticEntity
  def initialize window, x, y, w, h
    super window, x, y, w, h
    @window = window
    @x = x
    @y = y
  end

  def update
  end

  def draw
    Assets.plant.draw(@x * 64 - @window.getGameCamera.getXoffset, @y * 64 - @window.getGameCamera.getYoffset, 1, 2, 2)
  end

end
