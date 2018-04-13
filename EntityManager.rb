require './Player'

class EntityManager
  def initialize window, player
    @@entities = Array.new()
    @window = window
    @player = player
    addEntity(@player)
  end

  def update
    @@entities.each_with_index do |e, i|
      e = @@entities[i]
      e.update
    end
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
