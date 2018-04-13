require './Player'

class EntityManager
  def initialize window, player
    @@entities = Array.new()
    @window = window
    @player = player
    addEntity(@player)
  end

  def orderEntities x, y
    if a.getY < b.getY
      return 1
    elsif a.getY > b.getY
      return 1
    else
      return 0
    end
  end

  def update
    @@entities.each_with_index do |e, i|
      e = @@entities[i]
      e.update
    end
    @@entities = @@entities.sort_by {|x| x.getY}
  end

  def draw
    @@entities.each do |i|
      i.draw
    end
  end

  def addEntity(e)
    @@entities.push e unless @@entities.include?(e)
  end

  def getEntity(id)
    return @@entities[id]
  end

  def getEntities
    return @@entities
  end

  def getPlayer
    return @player
  end

  def getHandler
    return @window
  end
end
