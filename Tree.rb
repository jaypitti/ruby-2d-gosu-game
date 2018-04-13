require './StaticEntity.rb'
require './Assets.rb'

class Tree < StaticEntity
  def initialize window, x, y, w, h
    super window, x, y, w, h
    @window = window
    @x = x * 64
    @y = y * 64

    @tree = Assets.plant
  end

  def update
  end

  def draw
    @tree.draw(@x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2)
  end



end
