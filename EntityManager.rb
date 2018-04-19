require './Player'
require './Monster'

class EntityManager
  def initialize window, player
    @entities = Array.new
    @monster = Monster.new window, 20, 20
    @monster2 = Monster.new window, 5, 20
    @monster3 = Monster.new window, 10, 15
    @monster4 = Monster.new window, 15, 20
    @monster5 = Monster.new window, 25, 5
    @window = window
    @player = player
    addEntity(@player)
    addEntity(@monster)
    addEntity(@monster2)
    addEntity(@monster3)
    addEntity(@monster4)
    addEntity(@monster5)

  end

  def update
    @entities.each_with_index do |e, i|
      e = @entities[i]
      e.update
      if !e.getActive
        @entities.delete(e)
      end
    end
    @entities = @entities.sort_by {|x| x.getY + x.getHeight / 2 }

  end

  def draw
    @entities.each do |i|
      i.draw
    end
  end

  def addEntity(e)
    @entities.push e unless @entities.include?(e)
  end

  def getEntity(id)
    return @entities[id]
  end

  def getEntities
    return @entities
  end

  def getPlayer
    return @player
  end

  def getHandler
    return @window
  end
end
