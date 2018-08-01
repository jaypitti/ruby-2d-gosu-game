class Inventory
  def initialize handler
    @invItems
    @handler = handler
    @active = false
  end

  def update
    if @handler.getGame.button_down? Gosu::KbE
      @active = true
    end
    if @handler.getGame.button_down? Gosu::KbQ
      @active = false
    end
    if !@active
    else
    end
  end

  def draw
  end

  def addItem item
    for i in item
      if i.getId == item.getId
        i.setCount
      end
    end

  end

  def getHandler
    return @handler
  end
end
