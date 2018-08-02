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
        Assets.tiles(0).draw(y * 64 - @window.getGameCamera.getXoffset.to_i, x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)
        @worldMap[y][x].draw(y * 64 - @window.getGameCamera.getXoffset.to_i,x * 64 - @window.getGameCamera.getYoffset.to_i, 0, 2, 2)

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
        when 5
          @worldMap[x][y] = Assets.tiles(3)
        when 6 
          @worldMap[x][y] = Assets.tiles(4)
        when 7
          @worldMap[x][y] = Assets.tiles(5)
        when 8
          @worldMap[x][y] = Assets.tiles(6)
        when 9 
          @worldMap[x][y] = Assets.tiles(7)
        when 10
          @worldMap[x][y] = Assets.tiles(8)
        when 11
          @worldMap[x][y] = Assets.tiles(9)
        when 12
          @worldMap[x][y] = Assets.tiles(10)
        when 13
          @worldMap[x][y] = Assets.tiles(11)
        when 14
          @worldMap[x][y] = Assets.tiles(12)
        when 15
          @worldMap[x][y] = Assets.tiles(13)
        when 16
          @worldMap[x][y] = Assets.tiles(14)
        when 17
          @worldMap[x][y] = Assets.tiles(15)
        when 18
          @worldMap[x][y] = Assets.tiles(16)
        when 19
          @worldMap[x][y] = Assets.tiles(17)
        when 20
          @worldMap[x][y] = Assets.tiles(18)
        when 21
          @worldMap[x][y] = Assets.tiles(19)
        when 22
          @worldMap[x][y] = Assets.tiles(20)
        when 23
          @worldMap[x][y] = Assets.tiles(21)
        when 24
          @worldMap[x][y] = Assets.tiles(22)
        when 25
          @worldMap[x][y] = Assets.tiles(23)
        when 26
          @worldMap[x][y] = Assets.tiles(24)
        when 27
          @worldMap[x][y] = Assets.tiles(25)
        when 28
          @worldMap[x][y] = Assets.tiles(26)
        when 29
          @worldMap[x][y] = Assets.tiles(27)
        when 30
          @worldMap[x][y] = Assets.tiles(28)
        when 31
          @worldMap[x][y] = Assets.tiles(29)
        when 32
          @worldMap[x][y] = Assets.tiles(30)
        when 33
          @worldMap[x][y] = Assets.tiles(31)
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
