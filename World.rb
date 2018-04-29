require 'gosu'
require './Assets.rb'
require './EntityManager.rb'
require './ItemManager'
require './Player.rb'
require './Tree.rb'

class World < Assets
  @worldMap
  @numberMap

  def initialize handler, path, w, h, player
    @window = handler
    #Width and Height of loaded map
    @w = w
    @h = h

    @entityManager = EntityManager.new @window, player
    @ItemManager = ItemManager.new handler

    @TILEWIDTH = @TILEHEIGHT = 64

    @worldMap = Array.new(@w * @w){Array.new(@h * @h)}
    @numberMap = Array.new(@w * @w){Array.new(@h * @h)}

    if path
      loadWorld path
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
    @ItemManager.update
  end

  def getTile(x, y)
    return @numberMap[x][y]
  end

  def draw
    @xStart = [0, @window.getGameCamera.getXoffset.to_i / @TILEWIDTH - 1].max
    @xEnd = [@w, (@window.getGameCamera.getXoffset.to_i + @window.getWidth) / @TILEWIDTH].min
    @yStart = [0, @window.getGameCamera.getYoffset.to_i / @TILEHEIGHT - 1].max
    @yEnd = [@h, (@window.getGameCamera.getYoffset.to_i + @window.getHeight) / @TILEWIDTH].min

    for x in (@yEnd).downto(@yStart)
      for y in (@xEnd).downto(@xStart)
        case @numberMap[x][y]
          when 0
            @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
          when 1
            @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i, 1, 2, 2)
          when 2
            @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i, 1, 2, 2)
          when 3
            Assets.tiles(0).draw(y * 64 - @window.getGameCamera.getXoffset.to_i, x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
          when 4
            Assets.tiles(0).draw(y * 64 - @window.getGameCamera.getXoffset.to_i, x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
          else
            Assets.tiles(2).draw(y * 64 - @window.getGameCamera.getXoffset.to_i, x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
        end
      end
    end
    @ItemManager.draw

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
            @worldMap[x][y] = Assets.tiles(0)
          when 4
            @entityManager.addEntity(Monster.new @window, x, y)
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
    renderWorld @numberMap, @w, @h
  end

  def getEntityManager
    return @entityManager
  end

  def getItemManager
    return @ItemManager
  end

  def getHandler
    return @window
  end

end
