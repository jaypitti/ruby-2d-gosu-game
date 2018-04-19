require './StaticEntity.rb'
require './Assets.rb'
require './Item'

class Tree < StaticEntity
  def initialize window, x, y, w, h
    super window, x, y, w, h
    @window = window
    @w = w
    @h = h
    @x = x * 64
    @y = y * 64

    @tree = Assets.plant
  end

  def update
  end

  def die
    item = Item.cactus.createNew @x, @y
    @window.getWorld.getItemManager.addItem(item)
    item.setPosition @x, @y
  end

  def draw
    @tree.draw(@x - @window.getGameCamera.getXoffset, @y - @window.getGameCamera.getYoffset, 1, 2, 2)
  end

  def getY
    return @y
  end

  def getHeight
    return @h
  end
end
