

class ItemManager
  def initialize handler
    @items = []
    @handler = handler
  end

  def update
    if @items
      @items.each_with_index do |e, i|
        e = @items[i]
        e.update
        if e.isPickedUp
          @items.delete(e)
        end
      end
    end
  end

  def draw
    if @items
      for i in @items
        i.draw
      end
    end
  end

  def addItem item
    item.setHandler(@handler)
    @items.push(item)
  end

  def getItems
    return @items
  end

end
