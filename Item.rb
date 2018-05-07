
require './Assets'
require './GameHandler'

class Item

  def initialize texture, name, id
    @items = Array.new(100)

    @@ITEMWIDTH = 1
    @@ITEMHEIGHT = 1

    @pickedup = false

    @texture = texture
    @handler
    @name = name
    @id = id

    @count = 1
    @x = 0
    @y = 0

    @items[id] = self;
  end

  def self.cactus
    return Item.new Assets.plant, "Cactus", 0
  end

  def self.player_item
    return Item.new Assets.player, "Player", 1
  end

  def pickedup
    return @@PICKEDUP
  end

  def update
    itemCollided
    # puts @count
  end

  def itemCollided
    a = gCB
    b = @handler.getWorld.getEntityManager.getPlayer.getCollisionBox
      if boxOverlap(a,b)
        puts "HERE"
        @pickedup = true
      end
  end

  def overlap(a,b,x,y)
      return [a,x].max < [b,y].min
  end

  def boxOverlap(a,b)
    return overlap(a[:x1].to_i,a[:x2].to_i,b[:x1].to_i,b[:x2].to_i) && overlap(a[:y1].to_i,a[:y2].to_i,b[:y1].to_i,b[:y2].to_i)
  end

  def gCB
    obj = {x1: (@x), y1: (@y), x2: @x + 16, y2: @y + 24}
    return obj
  end

  def draw
    @texture.draw(@x - @handler.getGameCamera.getXoffset, @y - @handler.getGameCamera.getYoffset, 1, 1)
  end

  def createNew x, y
    item = Item.new @texture, @name, @id
    return item
  end

  def setPosition x, y
    @x = x
    @y = y
  end

  def getCount
    return @count
  end

  def setCount count
    @count = count
  end

  def getId
    return @id
  end

  def isPickedUp
    return @pickedup
  end

  def setHandler handler
    @handler = handler
  end
end
