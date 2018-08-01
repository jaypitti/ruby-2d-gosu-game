require './Player'
require './Monster'

class EntityManager
  def initialize window, player
    @entities = Array.new
    # @monster = Monster.new window, 10, 10
    # @monster2 = Monster.new window, 5, 5
    # @monster3 = Monster.new window, 15, 15
    # @monster4 = Monster.new window, 15, 20
    # @monster5 = Monster.new window, 25, 5
    # @monster6 = Monster.new window, 10, 5
    # @monster7 = Monster.new window, 10, 15
    # @monster8 = Monster.new window, 5, 10
    # @monster9 = Monster.new window, 5, 15
    # @monster10 = Monster.new window, 10, 20
    # @monster11 = Monster.new window, 20, 10
    # @monster12 = Monster.new window, 20, 20

    @players


    @window = window
    @player = player
    addEntity(@player)
    # addEntity(@monster)
    # addEntity(@monster2)
    # addEntity(@monster3)
    # addEntity(@monster4)
    # addEntity(@monster5)
    # addEntity(@monster6)
    # addEntity(@monster7)
    # addEntity(@monster8)
    # addEntity(@monster9)
    # addEntity(@monster10)
    # addEntity(@monster11)
    # addEntity(@monster12)

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
    if @players
      @players.each_value {|p| p.draw}
    end
  end

  def addEntity(e)
    @entities.push e unless @entities.include?(e)
  end

  def setPlayer(e)
    puts e
    @entities.map do |i|
      if i == @player
        @player = e
        break
      end
    end
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
