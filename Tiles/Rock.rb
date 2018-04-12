require_relative './Assets.rb'
require_relative './singleTile.rb'

class Rock
  def initialize id
    super
    Tile.new Assets.stone, self, id
  end

  def isSolid
    return true
  end
end
