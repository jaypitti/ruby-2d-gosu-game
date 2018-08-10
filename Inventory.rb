require './Item'

class Inventory
  def initialize handler
    @invItems = []
    @handler = handler
    @active = false
    @assets = Assets.new
    @invListCenterX = 64 + 171;
    @invListCenterY = 48 + 400 / 2 + 5;
    
    addItem(Item.cactus.createNewInvItem 5, @handler)

  end

  def update
    if @handler.getGame.button_down? Gosu::KbE
      @active = true
      puts @active
    end
    if @handler.getGame.button_down? Gosu::KbQ
      @active = false
      puts @active
    end
    if !@active
    else
    end
  end

  def draw
    if(!@active)
      puts @active
      return
    end
    @assets.inventory_screen.draw 64, 48, 10, 1.3, 1.3
    @item = @invItems[0]
    @item.draw
  end

  def addItem item
    @invItems.push(item)
    for i in @invItems
      if i.getId == item.getId
        i.setCount(i.getCount + 1)
      end
    end

  end

  def getHandler
    return @handler
  end
end
