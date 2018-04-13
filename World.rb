require 'gosu'
require './Assets.rb'
require './EntityManager.rb'
require './Player.rb'
require './Tree.rb'

class World < Assets
  @worldMap
  @numberMap

  def initialize window, path, w, h
    @window = window
    @w = w
    @h = h

    @entityManager = EntityManager.new @window, Player.new(@window, 10, 10)

    @TILEWIDTH = @TILEHEIGHT = 64

    @worldMap = Array.new(@w * @w){Array.new(@h * @h)}
    @numberMap = Array.new(@w * @w){Array.new(@h * @h, 0)}

    if path
      loadWorld path
      renderWorld @numberMap, @w, @h
    else
      generateMap
    end
  end

  def checkForPath path
      for y in (@h).downto(0)
        for x in (@w).downto(0)
          @numberMap[x][y] = getRandomNumber
        end
        renderWorld @numberMap
      end
  end

  def getRandomNumber
    case rand(100) + 1
    when  5..7
        return 1
      when 0..2
        return 2
      when 10..100
        return 0
      end
    end

  def update
    @entityManager.update
  end

  def getTile(x, y)
    return @numberMap[x][y]
  end

  def draw

    @xStart = [0, @window.getGameCamera.getXoffset / @TILEWIDTH ].max
    @xEnd = [@w, (@window.getGameCamera.getXoffset + @window.getWidth) / @TILEWIDTH + 1].min
    @yStart = [0, @window.getGameCamera.getYoffset / @TILEHEIGHT ].max
    @yEnd = [@h, (@window.getGameCamera.getYoffset + @window.getHeight) / @TILEWIDTH + 1].min

    for x in (@yEnd).downto(@yStart)
      for y in (@xEnd).downto(@xStart)
        case @numberMap[x][y]
          when 0
            @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
          when 1
            @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i.to_i, 1, 2, 2)
          when 2
            @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i, 1, 2, 2)
          when 3
            Assets.tiles(0).draw(y * 64 - @window.getGameCamera.getXoffset.to_i, x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
          else
            Assets.tiles(0).draw(y * 64 - @window.getGameCamera.getXoffset.to_i, x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
        end
      end
    end
    @entityManager.draw
  end

  def renderWorld numberMap, w, h
    for x in (@w).downto(0)
      for y in (@h).downto(0)
        case @numberMap[x][y]
          when 0
            @worldMap[x][y] = Assets.tiles(0)
          when 1
            @worldMap[x][y] = Assets.tiles(1)
          when 2
            @worldMap[x][y] = Assets.tiles(2)
          when 3
            @entityManager.addEntity(Tree.new @window, x, y, 10, 10)
            @entities = @entityManager.getEntities
            @worldMap[x][y] = Assets.tiles(0)
          else
            @worldMap[x][y] = Assets.tiles(0)
        end
      end
    end
  end

  def getWidth
    return @w
  end

  def getHeight
    return @h
  end

  def loadWorld path
    loadedFile = File.read(path)
    stringArray = loadedFile.split(/\s+/).map(&:to_i)
    for x in (@w).downto(0)
      for y in (@h).downto(0)
        @numberMap[x][y] = stringArray[(x + y * @w)]
      end
    end
  end

  def getEntityManager
    return @entityManager
  end

end
